class GoalsController < ApplicationController 
    # routes for goals views
    # rake db:create_migration NAME=create_movies
    # rake db:create_migration NAME=create_users
    # rake db:migrate

    # edit is now working 
    
    # delete is now working

    #create is working 
    # read is working too

    #in browser no dots?
    # add routing protection so you cannot jump to goal that is not yours
    

    get '/goals' do 
        # binding.pry
        if logged_in? 
            @user = current_user
            # @goals = Goal.all 
            @goals = Goal.all.select { |goal| goal.user_id == current_user.id } 
            erb :'goals/goals'
        else
            redirect to '/login'
        end
    end

    get '/goals/new' do
        if logged_in? && session[:user_id] == current_user.id 
            @user = current_user
            erb :'goals/new'
        else
            redirect to '/login'
        end
    end
    
    get '/goals/:id/edit' do 
        # binding.pry
        @goal = Goal.find_by(id: params[:id])
        
        if logged_in? && current_user.username == @goal.user.username 
            erb :'goals/edit'
        else
            redirect to '/login'
        end
    end

    post '/goals/:id' do 
        # binding.pry
        @goal = Goal.find_by(id: params[:id])
        @goal.update(content: params[:content])
        if logged_in? && params[:content] != "" && current_user.username == @goal.user.username 
            # erb :'goals/show'
            redirect to "/goals/#{@goal.id}"
        elsif
            redirect to "/goals/#{@goal.id}/edit"
        else
            redirect to '/login'
        end
    end

    get '/goals/:id' do 
        @goal = Goal.find_by(id: params[:id])
        if logged_in? && current_user.username == @goal.user.username
            # binding.pry
            erb :'goals/show'
        else
            redirect to '/login'
        end
    end 

    post '/goals' do 
        # binding.pry
        if params[:content] == ""
            redirect to '/goals/new'
        else
            @goal = Goal.create(content: params[:content])
            current_user.goals << @goal
            @goal.save
            redirect to "/goals/#{@goal.id}"
        end
    end

    patch '/goals/:id' do 
        if params[:content] == ""
            redirect to "/goals/#{params[:id]}/edit"
        else
            @goal = Goal.find_by(id: params[:id])
            @goal.update(content: params[:content])
            @goal.save 

            redirect to "/goals/#{@goal.id}"
        end
    end

    delete '/goals/:id/delete' do # this is working now
        @goal = Goal.find_by(id: params[:id])
        # binding.pry
        if logged_in? && current_user.username == @goal.user.username
           
            @goal.delete
            redirect to '/goals'
        end
        
    end
end