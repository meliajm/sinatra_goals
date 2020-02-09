class UsersController < ApplicationController 

    #is it okay for only the owner of a goal to see their goals?
    # other users cannot see other users' goals?

    # routes for user views

    get '/' do 
        erb :'users/index'
    end

    get '/signup' do 
        erb :'users/signup'
    end

    post "/signup" do 
        if params[:username] == "" || params[:email] == "" || params[:password] == ""
            redirect to '/'
        else
            User.create(username: params[:username], email: params[:email], password: params[:password])
            redirect to '/goals/goals'
        end
    end

    # get '/goals/goals'

    get '/login' do 
        erb :'users/login'
    end

    post '/login' do
        @user = User.find_by(username: params[:username])
        if @user && @user.authenticate(param[:password])
            session[:user_id] = @user.id 
            redirect to 'goals/goals'
        else
            redirect to '/'
        end
    end

    get "logout" do 
        session.clear
        redirect to "/"
    end

    get '/owners/:id/edit' do
        
    end



end