helpers do
  def find_user

    if session[:user_id].nil? || User.find_by_id(session[:user_id]).nil?
      false
    else
      User.find_by_id(session[:user_id])
    end
  end
  
end
