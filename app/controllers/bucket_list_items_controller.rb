class BucketListItemsController < ApplicationController
  get '/list_items' do
    if logged_in?(session)
      @user = current_user(session)
      @bucket_items = BucketItem.all
      erb :"/list_items/list_items"
    else
      redirect "/login"
    end
  end

  get '/list_items/new' do
    if logged_in?(session)
      erb :'/list_items/new'
    else
      redirect "/login"
    end
  end

  post '/list_items' do
    if !params[:content].empty?
      user = User.find_by(id: session[:user_id])
      @bucket_items = BucketItem.all
      list_item = BucketItem.create(content: params[:content])
      user.bucket_items << list_item
      redirect to "/list_items/list_items"
    else
      redirect to "/list_items/new"
    end
  end
end
