class UsersController < ApplicationController
    get '/' do
        erb :'users/index'
    end

    get '/signup' do
        redirect_if_logged_in
        erb :'users/signup'
    end

    post '/signup' do
        user = User.new(params)
        
        if user.valid?
            user.save
            session[:user_id] = user.id
            redirect '/tweets'
        else
            redirect '/signup'
        end
    end

    get '/login' do
        redirect_if_logged_in
        erb :'users/login'
    end

    post '/login' do
        user = User.find_by(username: params[:username])
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect '/tweets'
        end
    end

    get '/logout' do
        if current_user
            session.clear
            redirect '/login'
        else
            redirect '/'
        end
    end

    get '/users/:slug' do
        @user = User.find_by_slug(params[:slug])
        erb :'users/show'
    end

end
