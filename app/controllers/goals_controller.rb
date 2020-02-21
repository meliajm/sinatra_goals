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
    
    get '/goals/:slug/edit' do 
        @goal = Goal.find_by_slug(params[:slug])
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

    patch '/goals/:slug' do 
        @goal = Goal.find_by_slug(params[:slug])
        validate
        # binding.pry
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
            redirect to "/goals/#{@goal.slug}"
        end
    end

    delete '/goals/:slug' do 
        @goal = Goal.find_by_slug(params[:slug])
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