require './config/environment'


class ApplicationController < Sinatra::Base
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
      @current_user = User.find_by_id(session[:user_id])
    end

    def logged_in?(session)
      !!current_user(session)
    end

    def redirect_if_not_logged_in
      if !logged_in?(session)
        redirect "/users/login"
      end
    end
  end
end
