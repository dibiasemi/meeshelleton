get '/users/new' do
  erb :'users/new'
end

post '/users' do
  @user = User.new(params[:user])
  # This is where validations get accessed - RIGHT before you save the object you instantiated
  if @user.save
    redirect '/sessions/new'
  else
    @errors = @user.errors.full_messages
    erb :'users/new'
  end
end

get '/users/:id' do
  @user = User.find(params[:id])
  erb :'users/show'
end
