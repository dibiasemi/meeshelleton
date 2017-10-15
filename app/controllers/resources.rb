get '/resources' do
  @resource = Resource.all
  erb :"resources/index"
end

# This is a RESOURCE path - not a FILE path
get '/resources/new' do
# Protect your controller --> redirect '/sessions/new' if session[:id] = nil
# It will never even render this if you're not logged in, it won't go to the create page
  redirect_if_not_logged_in
  @resource = Resource.new
  erb :"resources/new"
end

post '/resources' do
  redirect_if_not_logged_in
# The following params[:resource] will pull out the value of the whole nested hash called "resource"
  @resource = Resource.new(params[:resource])

  if @resource.save
# Logged in user is creating resource, it will be associated via our associations
# Update database to have a foreign key (user_id)

# Take the resource you just instantiated and shove it into the collection which is also a defined association, so when you create a new resource, it will also associate it
    current_user.resources << @resource
# redirect when you no errors - it is a happy path
    redirect '/resources'
# ALWAYS HANDLE ERRORS IN 'ELSE' STATEMENT - tell the user what happened
  else
# Errors in an ActiveModel object that has a full_messages property that will return an array of strings
# Your object has an attribute called "errors" that you can access
# 'erb' when you error Ex. Render a form
    @errors = @resource.errors.full_messages
    erb :"resources/new"
  end
end

get '/resources/:id' do
  @resource = Resource.find_by(id: params[:id])
  erb :"resources/show"
end

get '/resources/:id/edit' do

  redirect_if_not_logged_in

  @resource = Resource.find_by(id: params[:id])

  authorize!(@resource.user)
  erb :"resources/edit"
end

put '/resources/:id' do
  aredirect_if_not_logged_in

  @resource = Resource.find_by(id: params[:id])

  redirect_if_not_authorized(@resource.user)

  if @resource.update(params[:resource])
    redirect '/resources'
  else
    @errors = @resource.errors.full_messages
    erb :"resources/edit"
  end

end

delete '/resources/:id' do
  redirect_if_not_logged_in

  @resource = Resource.find_by(id: params[:id])

  redirect_if_not_authorized(@resource.user)

  @resource.destroy
  redirect '/resources'
end
