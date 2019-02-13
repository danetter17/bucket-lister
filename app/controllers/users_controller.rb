class UsersController < ApplicationController

  get '/signup' do
    if logged_in?(session)
      redirect to '/bucket-list-items'
    else
      erb :"/users/signup"
    end
  end

  post '/signup' do
    #binding.pry
    if !params.has_value?("")
      user = User.create(params)
      session[:user_id] = user.id
      redirect '/bucket-list-items'
    else
      redirect "/signup"
    end
  end


end
