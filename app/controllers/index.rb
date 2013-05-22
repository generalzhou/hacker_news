get '/' do
  # Look in app/views/index.erb
  erb :index
end

get '/new' do 
  redirect '/'
end

get '/threads' do
  #comments on post by signed in users
end

get '/comments' do

end

get '/ask' do 
  
end
