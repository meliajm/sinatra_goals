require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "goals_application_secret" # do something here to encode?
  end

  helpers do 
    def logged_in?
        !!sessions[:user_id]
    end
    
    def current_user
        User.find(sessions[:user_id])
    end
  end


end