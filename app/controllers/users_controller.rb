class UsersController < ApplicationController

  get '/users/signup' do
    if logged_in?(session)
      redirect to '/bucket_list_items'
    else
      erb :"/users/signup"
    end
  end

  post '/signup' do
    #binding.pr-
    if !params.has_value?("")
      user = User.create(params)
      session[:user_id] = user.id
      redirect '/bucket_list_items'
    else
      redirect "/signup"
    end
  end

  get '/users/login' do
    if logged_in?(session)
      redirect '/bucket_list_items'
    else
      erb :"users/login"
    end
  end

  post '/login' do
    user = User.find_by(:username => params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect '/bucket_list_items'
    else
      erb :"users/login"
    end
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :"users/show"
  end

  get '/logout' do
    if logged_in?(session)
      session.clear
      redirect to '/users/login'
    else
      redirect to '/'
    end
  end
end
