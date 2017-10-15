helpers do

  def current_user
# This ||= means:
# The first time you call this, it's going to be nil, go to the right side, go to the database, go get that object and assign it to that variable,
# The secomnd time you call it, it won't have to go to the database again
# limit the number of times you go to the datebase
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def set_current_userid(user_id)
    session[:user_id] = user_id
  end

  def get_current_userid
    session[:user_id]
  end

  def logged_in?
    session[:user_id] != nil
  end

# Authentication: you are who you say you are
# method can be called: "redirect_if_not_logged_in"
  def redirect_if_not_logged_in
    redirect '/sessions/new' unless logged_in?
  end

# Authorization: you have access to do the thing
  def redirect_if_not_authorized(user)
    redirect '/not_authorized' unless authorized?(user)
  end

  def authorized?(user)
    current_user == user
  end
end