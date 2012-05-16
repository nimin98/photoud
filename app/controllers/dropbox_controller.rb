require 'dropbox_sdk'

APP_KEY     = '0yocyu00uiy2rah'
APP_SECRET  = 'pi47gfrs7gnufga'
ACCESS_TYPE = :dropbox

class DropboxController < ApplicationController

  ####
  def authorize

    if not params[:oauth_token] then
      dbsession = DropboxSession.new(APP_KEY, APP_SECRET)
      session[:dropbox_session] = dbsession.serialize
      redirect_to dbsession.get_authorize_url authorize_path
    else
      dbsession = DropboxSession.deserialize(session[:dropbox_session])
      dbsession.get_access_token
      redirect_to upload_path
    end

  end

  ####
  def upload
    if !session[:dropbox_session] then
      redirect_to authorize_path
    else
      dbsession = DropboxSession.deserialize(session[:dropbox_session])
      if !dbsession.authorized? then
        redirect_to authorize_path
      else
        client = DropboxClient.new(dbsession, ACCESS_TYPE)        
        info   = client.account_info

        if request.method != "POST" then
          render :inline =>
            "#{info['email']} <br/><%= form_tag({:action => :upload}, :multipart => true) do %><%= file_field_tag 'file' %><%= submit_tag %><% end %>"
        else
          resp = client.put_file(params[:file].original_filename, params[:file].read)
          render :text => "Upload successful! File now at #{resp['path']}"
        end
      end
    end
  end

end
