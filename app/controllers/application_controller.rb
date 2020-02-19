require './config/environment' # does this app need this?

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions #unless test?
    set :session_secret, "goals_application_secret" # do something here to encode?
  end

  helpers do 
    def logged_in?
        !!session[:user_id]
    end

    def current_user
        User.find(session[:user_id])
    end

    def 
        current_user.username == @goal.user.username
    end
  end


end