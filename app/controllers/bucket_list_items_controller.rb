class BucketListItemsController < ApplicationController
  get '/list_items' do
    if logged_in?(session)
      @user = current_user(session)
      @list_items = BucketItem.all
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
      list_item = BucketItem.create(content: params[:content])
      user.list_items << list_item
      redirect to "/list_items/#{list_item.id}"
    else
      redirect to "/list_items/new"
    end
  end
end
