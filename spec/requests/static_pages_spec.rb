require 'spec_helper'

describe "StaticPages" do

  describe "Home Page" do
    it "should have the content 'Photoud'" do
      visit '/static_pages/home'
      page.should have_selector('title', :text => 'Photoud | Home')
    end
  end

  describe "Help Page" do
    it "should have the content 'Help'" do
      visit '/static_pages/help'
      page.should have_selector('title', :text => 'Photoud | Help')
    end
  end

  describe "About Page" do
    it "should have the content 'About Us'" do
      visit '/static_pages/about'
      page.should have_selector('title', :text => 'Photoud | About Us')
    end
  end

end
