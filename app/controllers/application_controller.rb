require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    enable :sessions
    set :session_secret, "secret"
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do 
    erb :home
  end

  get '/login' do
    if is_logged_in?
        redirect to '/tweets'
    else
        erb :'users/login'
    end
end


  helpers do
    def is_logged_in?
      !!session[:user_id]
    end
  
    def current_user
      User.find(session[:user_id])
    end

    def is_not_blank?(hash)
      array = []
      hash.each do |k,v|
        if hash[k] == "" || hash[k] == " "
          array << v
        end
      end
      array.empty?
      #hash.values
    end

  end

end
