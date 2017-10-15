get '/session_viewer' do
  session.inspect
end

get '/sessions/new' do
  erb :'sessions/new'
end

post '/sessions' do
  @user = User.find_by(email: params[:user][:email])

  if @user && @user.authenticate(params[:user][:password])
    set_current_userid(@user.id)
    redirect "users/#{@user.id}"
  else
    @errors = "Either username or password is incorrect"
    erb :'sessions/new'
  end
end

get '/logout' do
  set_current_userid(nil)
  session.clear
  redirect '/'
end

get '/not_authorized' do
  erb :not_authorized
end
