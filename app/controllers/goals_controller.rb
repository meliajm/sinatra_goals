class GoalsController < ApplicationController 
    
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
    
    get '/goals/:slug/edit' do 
        @goal = Goal.find_by_slug(params[:slug])
        @user = current_user
        validate
        erb :'goals/edit'
    end

    patch '/goals/:slug' do 
        @goal = Goal.find_by_slug(params[:slug])
        validate
        @goal.update(content: params[:content], by_when: params[:by_when],  completed: params[:completed])
        if @goal.valid?
            redirect to "/goals/#{@goal.slug}"
        else
            redirect to "/goals/#{@goal.slug}/edit"
        end
        
    end

    get '/goals/:slug' do 
        @goal = Goal.find_by_slug(params[:slug])
        validate
        erb :'goals/show'
    end 

    post '/goals' do 
        @goal = Goal.create(content: params[:content], by_when: params[:by_when], completed: params[:completed])
        if !@goal.valid?
            redirect to '/goals/new'
        else
            current_user.goals << @goal
            redirect to "/goals/#{@goal.slug}"
        end
    end

    delete '/goals/:slug' do 
        @goal = Goal.find_by_slug(params[:slug])
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