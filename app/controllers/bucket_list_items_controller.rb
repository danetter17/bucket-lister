class BucketListItemsController < ApplicationController
  get '/bucket_list_items' do
    redirect_if_not_logged_in
      @user = current_user(session)
      @bucket_list_items = BucketListItem.all
      erb :"/bucket_list_items/bucket_list_items"
  end

  get '/bucket_list_items/new' do
    redirect_if_not_logged_in
    erb :'/bucket_list_items/new'
  end

  get '/bucket_list_items/my_list' do
    redirect_if_not_logged_in
      @user = current_user(session)
      @bucket_list_items = BucketListItem.all
      erb :'/bucket_list_items/my_list'
  end

  post '/bucket_list_items' do
    if !params[:content].empty?
      user = User.find_by(id: session[:user_id])
      bucket_list_item = BucketListItem.create(content: params[:content])
      user.bucket_list_items << bucket_list_item
      redirect to "/bucket_list_items/#{bucket_list_item.id}"
    else
      redirect to "/bucket_list_items/new"
    end
  end

  get '/bucket_list_items/:id' do
    redirect_if_not_logged_in
      @bucket_list_item = BucketListItem.find_by(id: params[:id])
      erb :'bucket_list_items/show_bucket_list_item'
  end

  get '/bucket_list_items/:id/edit' do
    redirect_if_not_logged_in
      @bucket_list_item = BucketListItem.find_by(id: params[:id])
      if @bucket_list_item && @bucket_list_item.user == current_user(session)
        erb :'/bucket_list_items/edit'
      else
        redirect '/bucket_list_items'
      end
  end

  patch '/bucket_list_items/:id' do
    @bucket_list_item = BucketListItem.find_by(id: params[:id])
    if @bucket_list_item && !params[:content].empty? && @bucket_list_item.user == current_user(session)
      @bucket_list_item.update(content: params[:content])
      redirect '/bucket_list_items'
    else
      redirect "/bucket_list_items/new"
    end
  end

  delete "/bucket_list_items/:id/delete" do
    @bucket_list_item = BucketListItem.find_by(id: params[:id])
    if @bucket_list_item
      if @bucket_list_item.user == current_user(session)
        @bucket_list_item.delete
      end
    end
    redirect "/bucket_list_items"
  end
end
