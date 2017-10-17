get '/resources' do
  @resources = Resource.all
  erb :"resources/index"
end


get '/resources/new' do
  redirect_if_not_logged_in
  @resource = Resource.new
  erb :"resources/new"
end

post '/resources' do
  redirect_if_not_logged_in
  @resource = Resource.new(params[:resource])

  if @resource.save
    current_user.resources << @resource
    redirect '/resources'
  else
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
  redirect_if_not_authorized(@resource.user)
  erb :"resources/edit"
end

put '/resources/:id' do
  redirect_if_not_logged_in
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
