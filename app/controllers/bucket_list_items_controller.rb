class BucketListItemsController < ApplicationController
  get '/items/bucket_list_items' do
    if logged_in?(session)
      @user = current_user(session)
      @bucket_list_items = BucketListItem.all
      erb :"bucket-list-items/bucket-list-items"
    else
      redirect "/login"
    end
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
end
