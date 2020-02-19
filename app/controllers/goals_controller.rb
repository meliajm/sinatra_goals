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
    # added routing protection so you cannot jump to goal that is not yours
    # added validate to routes 
    # can add slugs with modules
    

    get '/goals' do 
        if logged_in? 
            @user = current_user 
            user_goals = @user.goals            
            @completed_goals = user_goals.completed_goals
            @not_completed_goals = user_goals.not_completed_goals
            @percentage_complete = user_goals.percent_complete
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
        @goal = Goal.find_by(id: params[:id])
        @user = current_user
        # binding.pry

        validate
        erb :'goals/edit'
        # if logged_in? && goal_belongs_to_user? 
        #     erb :'goals/edit'
        # else
        #     redirect to '/login'
        # end
    end

    patch '/goals/:id' do 
        @goal = Goal.find_by(id: params[:id])
        validate
        # binding.pry
        @goal.update(content: params[:content], by_when: params[:by_when],  completed: params[:completed])
        if @goal.valid?
            redirect to "/goals/#{@goal.id}"
        else
            redirect to "/goals/#{@goal.id}/edit"
        end
        
    end

    get '/goals/:id' do 
        @goal = Goal.find_by(id: params[:id])
        validate
        erb :'goals/show'
        # binding.pry
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
        validate   
        @goal.delete
        redirect to '/goals'
    end


    helpers do 
        def goal_belongs_to_user?
            current_user.username == @goal.user.username
        end

        def validate
            if !logged_in? || !goal_belongs_to_user?
                redirect to '/login'
            end
        end
    end

end