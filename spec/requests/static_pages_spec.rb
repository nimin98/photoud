require 'spec_helper'
require 'support/utilities'

describe "StaticPages" do
  let(:base_title) { "Photoud" }
  subject { page }

  describe "Click Links" do
    it "should have the right links on the layout" do
      visit root_path
      click_link "About"
      page.should have_selector('title', text: full_title('About Us'))
      click_link "Help"
      page.should have_selector('title', text: full_title('Help'))
      click_link "Contact"
      page.should have_selector('title', text: full_title('Contact'))
      click_link "Home"
      page.should have_selector('title', text: full_title(''))
    end
  end

  describe "Home Page" do
    before { visit root_path }

    it { should     have_selector('title', text: full_title('')) }
    it { should_not have_selector('title', text: full_title('Home')) }
  end

  describe "Help Page" do
    before { visit help_path}

    it { should have_selector('title', text: full_title('Help')) }
  end

  describe "About Page" do
    before { visit about_path }

    it { should have_selector('title', text: full_title('About Us')) }
  end

  describe "Contact Page" do
    before { visit contact_path }

    it { should have_selector('title', text: full_title('Contact')) }
  end

end
