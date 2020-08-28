require './config/environment'
require 'rack-flash'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, 'secret'
    use Rack::Flash
  end

  get '/' do 
    erb :home
  end

  get '/signup' do
    redirect '/tweets' if logged_in?
    erb :signup
  end

  post '/signup' do
    redirect '/' if logged_in?
    user = User.create(params)
    if user.valid?
      session[:user_id] = user.id
      redirect '/tweets'
    else
      redirect '/signup'
    end
  end

  get '/login' do
    redirect '/tweets' if logged_in?
    erb :login
  end

  post '/login' do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect '/tweets'
    else
      redirect '/login'
    end
  end

  get '/logout' do
    session.clear
    redirect '/login'
  end

  helpers do
    def current_user
      User.find_by(id: session[:user_id])
    end

    def logged_in?
      !!current_user
    end

    def redirect_if_not_logged_in
      if !current_user
        redirect '/log-in'
      end
    end
  end

end
