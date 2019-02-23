class BucketListItemsController < ApplicationController
  get '/bucket_list/list_items' do
    if logged_in?(session)
      @user = current_user(session)
      @list_items = BucketListItem.all
      erb :"/bucket_list/list_items"
    else
      redirect "/login"
    end
  end

  post '/list_items' do
    if !params[:content].empty?
      user = User.find_by(id: session[:user_id])
      list_item = BucketListItem.create(content: params[:content])
      user.list_items << list_item
      redirect to "/list_items/#{list_item.id}"
    else
      redirect to "/bucket_list/new"
    end
  end
end
