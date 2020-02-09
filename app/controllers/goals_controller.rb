class GoalsController < ApplicationController 
    # routes for goals views
    # rake db:create_migration NAME=create_movies
    # rake db:create_migration NAME=create_users
    # rake db:migrate

    get '/goals' do 
        if logged_in?
            @goals = Goal.all 
            @user = current_user
            erb :'goals/goals'
        else
            redirect to '/login'
        end
    end

    get '/goals/new' do
        if logged_in?
            erb :'goals/new'
        else
            redirect to '/login'
        end
    end

    post '/goals' do 
        if params[:content] == ""
            redirect to '/goals/new'
        else
            @goal = Goal.new(content: params[:content])
            current_user.goals << @goal
        end
    end

    get '/goals/:id' do 
        if logged_in? 
            @goal = Goal.find_by(id: params[:id])
            erb :'goals/show'
        else
            redirect to '/login'
        end
    end

    get '/goals/:id/edit' do 
        @goal = Goal.find_by(id: params[:id])
        if logged_in?
            erb :'goals/edit'
        else
            redirect to '/login'
        end
    end

    patch '/goals/:id' do 
        if params[:content] == ""
            redirect to "/goals/#{params[:id]}/edit"
        else
            @goal = Goal.find_by(id: params[:id])
            @goal.update(content: params[:content])
        end
    end

    delete '/goals/:id/delete' do
        @goal = Goal.find_by(id: params[:id])
        if logged_in? && current_user.username == @goal.username
            goal.delete(params[:id])
            redirect to '/goals'
        end
    end


end