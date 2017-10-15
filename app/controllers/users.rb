get '/users/new' do
  erb :'users/new'
end

post '/users' do
  #Don't save directly to database - create a "new" user in Ruby memory
  @user = User.new(params[:user])
  # This is where validations get accessed - RIGHT before you save the object you instantiated
  if @user.save
  # redirect to restricted area/homepage/main root (ex. '/' ) or have the user login
    redirect '/sessions/new'
  else
    @errors = @user.errors.full_messages
    erb :'users/new'
    #Render the 'new' page - a.k.a sign up form
  end
end

get '/users/:id' do
  @user = User.find_by(id: params[:id])
  erb :'users/show'
end
