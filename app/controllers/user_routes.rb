
get "/create_account" do

  erb :create_account, :locals => {:error => false}
end

post '/create_account' do
   user = User.new(params)
   if user.valid?
    user.save
    session[:user_id] = user.id
    redirect '/'
  else
    erb :create_account, :locals => {:error => user.errors.full_messages}
  end
end

get '/login' do
  erb :login, :locals => {:error => false}
end

post "/login" do
  user = User.authenticate(params)
  if user
    session[:user_id] = user.id
    redirect '/'
  else
    erb :login, :locals => {:error => true}
  end  
end

get '/logout' do
  session.clear
  redirect '/'
end

post '/update_profile' do
  user = find_user
  p user
  user.email = params[:email]
  puts 'email assigned'
  user.about = params[:about]
  puts 'about assigned'
  user.save
  redirect "/user/#{user.id}"
end

get '/change_password' do
  user = find_user
  if user
    erb :change_password, :locals => {:user => user}
  else
    redirect '/'
  end
end

post '/change_password' do
  user = find_user
  if User.authenticate(name: user.name, password: params[:current_password])
    if params[:new_password] == params[:confirm_new_password]
      user.password = (params[:new_password])
      user.save
      redirect "/user/#{user.id}"
    else
      "Passwords don't match"
    end
  else
    "Authentication failed beeyotch!"
  end

end

get '/user/:id' do
  current_user = find_user
  if current_user && current_user.id.to_s == params[:id]
    erb :edit_profile, :locals => {:user => current_user}
  elsif User.find(params[:id])
    erb :view_profile, :locals => {:user => User.find(params[:id])}
  else
    "No such user."
  end
end
