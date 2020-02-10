minimum viable product

a user can:
    -login
    -write goals, this is create
    -see their goals, this is read
    -edit goals, this is update
    -delete goals, instead of delete maybe crossout?
    -logout


<% if logged_in? && @goal.user.username == current_user.username %>
    <h1>Update your goal</h1>

    <form action=<%="/goals/#{@goal.id}"%> method="POST">
    <input id="hidden" type="hidden" name="_method" value="patch">
    <label for="content">Edit your goal's content: </label>
    <br>
    <input type="text" name="content" id="content" value="<%= @goal.content %>">
    <input type="submit" id="submit" name="submit" value="Edit Goal">
    </form>
<% end %>

<h3><% if logged_in? && @goal.user.username == current_user.username %>
    <h4>Update Goal</h4>

    <form action=<%="/goals/#{@goal.id}"%> method="POST">
    <input id="hidden" type="hidden" name="_method" value="patch">
    <label for="content">Edit your goal's content: </label>
    <br>
    <input type="text" name="content" id="content" value="<%= @goal.content %>">
    <input type="submit" id="submit" name="submit" value="Edit Goal"/>
    </form>
<% end %></h3>


