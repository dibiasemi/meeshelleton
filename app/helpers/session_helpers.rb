helpers do
  def current_user?(user_id)
    get_current_userid == user_id
  end

  def set_current_userid(user_id)
    session[:user_id] = user_id
  end

  def get_current_userid
    session[:user_id]
  end

  def logged_in?
    !!get_current_userid
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

end
