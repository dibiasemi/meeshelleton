get '/session_viewer' do
  session.inspect
end

get '/sessions/new' do
  erb :'sessions/new'
end

post '/sessions' do
  @user = User.find_by(email: params[:user][:email])

  if @user.authenticate(params[:user][:password])
  #This is where you create the session key called "user_id" and set it equal to the current user's id.
    set_current_userid(@user.id)
  #This is a happy path, it can redirect to wherever you want after the user logins - the homepage, the user's profile page, etc.
    redirect "users/#{@user.id}"
  else
    @errors = "Username or password is incorrect"
    erb :'sessions/new'
  end
end

get '/logout' do
  set_current_userid(nil)
  redirect '/sessions/new'
end

# I prefer not to delete the session but to just simply "logout"
# delete '/sessions' do
#   session.delete(:user_id)
#   redirect '/'
# end

get '/not_authorized' do
  erb :not_authorized
end