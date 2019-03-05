require './config/environment'
# require 'sinatra/base'
# require 'rack-flash'

class ApplicationController < Sinatra::Base
  # enable :sessions
  # use Rack::Flash
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secure_password"
  end

  get '/' do
    erb :welcome
  end

  helpers do
    def current_user(session)
      @user = User.find_by_id(session[:user_id])
    end

    def logged_in?(session)
      !!current_user(session)
    end
  end

end
