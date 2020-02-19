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
            # @goals = Goal.all.select { |goal| goal.user_id == current_user.id } 
            @goals = Goal.find_goals_by_user(@user)
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
        
        if logged_in? && goal_belongs_to_user? 
            erb :'goals/edit'
        else
            redirect to '/login'
        end
    end

    patch '/goals/:id' do 
        @goal = Goal.find_by(id: params[:id])
        @goal.update(content: params[:content], by_when: params[:by_when],  completed: params[:completed])
        # binding.pry
        if logged_in? && @goal.valid? && goal_belongs_to_user? 
            # erb :'goals/show'
            redirect to "/goals/#{@goal.id}"
        # elsif 
        #     redirect to "/goals/#{@goal.id}/edit"
        else
            redirect to '/login'
        end
    end

    get '/goals/:id' do 
        @goal = Goal.find_by(id: params[:id])
        # binding.pry
        if logged_in? && goal_belongs_to_user?
            # binding.pry
            erb :'goals/show'
        else
            redirect to '/login'
        end
    end 

    post '/goals' do 
        # binding.pry
        @goal = Goal.create(content: params[:content], by_when: params[:by_when], completed: params[:completed])

        if !@goal.valid?
            redirect to '/goals/new'
        else
            # @goal = Goal.create(content: params[:content], by_when: params[:by_when], completed: params[:completed])
            current_user.goals << @goal
            # @goal.save
            redirect to "/goals/#{@goal.id}"
        end
    end

    delete '/goals/:id' do 
        @goal = Goal.find_by(id: params[:id])
        # binding.pry
        if logged_in? && goal_belongs_to_user?
           
            @goal.delete
            redirect to '/goals'
        end
    end


    helpers do 
        def goal_belongs_to_user?
            current_user.username == @goal.user.username
        end
    end

end