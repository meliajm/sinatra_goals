class UsersController < ApplicationController 

    #is it okay for only the owner of a goal to see their goals?
    # other users cannot see other users' goals?

    # routes for user views

    get '/' do 
        if logged_in?
            redirect to '/goals'
        else
            erb :index
        end
    end

    get '/signup' do 
        if logged_in?
            redirect to '/goals'
        else
            erb :'users/new'
        end
    end

    post "/signup" do 
        if params[:username] == "" || params[:email] == "" || params[:password] == ""
            redirect to '/signup'
        else
            @user = User.create(username: params[:username], email: params[:email], password: params[:password])
            session[:user_id] = @user.id 
            redirect to '/goals'
        end
    end

    # get '/goals/goals'

    get '/login' do 
        if logged_in?
            redirect to '/goals'
        else
            erb :'users/login'
        end
    end

    post '/login' do
        @user = User.find_by(username: params[:username])
        if @user && @user.authenticate(param[:password])
            session[:user_id] = @user.id 
            redirect to '/goals'
        else
            redirect to '/signup' if !logged_in?
        end
    end

    get "/logout" do 
        if logged_in?
            session.clear
            redirect to "/login"
        else
            redirect to '/'
        end
    end

end