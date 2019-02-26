class BucketListItemsController < ApplicationController
  get '/bucket_list_items' do
    if logged_in?(session)
      @user = current_user(session)
      @bucket_list_items = BucketListItem.all
      erb :"/bucket_list_items/bucket_list_items"
    else
      redirect "/login"
    end
  end

  get '/bucket_list_items/new' do
    if logged_in?(session)
      erb :'/bucket_list_items/new'
    else
      redirect "/login"
    end
  end

  post '/bucket_list_items' do
    if !params[:content].empty?
      user = User.find_by(id: session[:user_id])
      @bucket_list_items = BucketListItem.all
      bucket_list_item = BucketListItem.create(content: params[:content])
      user.bucket_list_items << bucket_list_item
      redirect to "/bucket_list_items/#{bucket_list_item.id}"
    else
      redirect to "/bucket_list_items/new"
    end
  end

  get '/bucket_list_items/:id' do
    if logged_in?(session)
      @bucket_list_item = BucketListItem.find_by(id: params[:id])
      erb :'/bucket_list_items/show'
    else
      redirect to "/login"
    end
  end
end
