minimum viable product

https://drive.google.com/open?id=12NVwVjyfVrIYdo652CntYxL7qs9C7S59
https://meliajm.github.io/welcome_to_your_goals

a user can:
    -login
    -write goals, this is create
    -see their goals, this is read
    -edit goals, this is update
    -delete goals, instead of delete maybe crossout?
    -logout

stretch feature check off their goals, submit that checked off page

add by_when and timestamps

goals                   completed goals
___________          ______________________

1                       check 
2                       check 
3                       check

percentage complete

1. [x] add logic for indexing goals properly in 2 columns
2. [x] output only 2 decimal places for percent completed
3. [x] pre-populate by when
4. [] figure out how to merge properly with github
5. [x] connect local email to github
6. [] add delete button to edit page


 <input type="date" name="by_when" id="by_when">

 <!--<% not_completed_goals_array = [] %>
    <% completed_goals_array = [] %>
    <p><% @goals.each do |goal| %>
        <% if goal.completed != "on"%>
            <% not_completed_goals_array << goal %>
        <% else %>  
            <% completed_goals_array << goal %>
        <% end %>
    <% end %>-->

       <!--<%total_goals = @goals.length %>
<h2><%= total_completed = total_completed.to_f  %></h2>
<h2><%= total_goals %></h2>
<h2><%= @user.goals.percent_complete%></h2>
<%= (total_completed/total_goals * 100).round(2)%>
<% total_completed = 0 %>
<% total_completed += 1 %>
-->

  <input type="checkbox" name="completed" value="<%= @user.id %>" <%='checked' if @goal.user==@user %>></input><br> 

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
# if logged_in? && goal_belongs_to_user? 
        #     erb :'goals/edit'
        # else
        #     redirect to '/login'
        # end

#is it okay for only the owner of a goal to see their goals?
    # other users cannot see other users' goals?

    # routes for user views
    # add links to index
    # hacks? ways to break in or break site?
    
    # any user can see all goals
   