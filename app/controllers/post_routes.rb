get '/submit' do
  erb :submit, :locals => {:error => false}
end

post '/submit' do
  post = Post.new(params)
  post.user = find_user
  if post.valid?
    post.save
    redirect "/post/#{post.id}"
  else
    erb :submit, :locals => {:error => post.errors}
  end
end

get '/post/:id/vote' do
  if (post = Post.find_by_id(params[:id])) &&  (user = find_user)
    unless post.users.find_by_id(user.id)
      post.users << user
    end
  end
  redirect '/'
end

get '/post/:id/unvote' do
  if (post = Post.find_by_id(params[:id])) &&  (user = find_user)
    if post.users.find_by_id(user.id)
      post.users.delete(user)
      erb :index
    end
  end
  redirect '/'
end


get '/post/:id' do
   if post = Post.find_by_id(params[:id])
      erb :view_post, :locals => { :post => post, :errors =>  false}
    else
      "Dumbass."
    end
end

post '/post/:id/add_comment' do
  post = Post.find_by_id(params[:id])
  redirect '/' if post.nil?
  comment = Comment.new(:text => params[:comment])
  comment.user = find_user
    if comment.valid?
      comment.save      
      post.comments <<  comment 
      redirect "/post/#{post.id}"
    else
      erb :view_post, :locals => { :post => post, :errors =>  comment.errors}
    end
end


