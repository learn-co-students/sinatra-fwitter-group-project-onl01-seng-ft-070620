class UsersController < ApplicationController


    get "/users/:slug" do
        @user = User.find_by_slug(params[:slug])
        erb :'users/show'
    end 

    get '/signup' do
        if is_logged_in?
            redirect to '/tweets'
        else
            erb :'users/signup'
        end
    end
    
    post '/signup' do
        if is_not_blank?(params)
            @user = User.new(params)
            @user.save
            session[:user_id] = @user.id
            redirect to '/tweets'
        else
          redirect to '/signup'
        end
    end

    get '/login' do
        if is_logged_in?
            redirect to '/tweets'
        else
            erb :'users/login'
        end
    end

    post '/login' do
        user = User.find_by(username: params[:username])
        if user && user.authenticate(params[:password])
          session[:user_id] = user.id
          redirect '/tweets'
        else
          redirect '/'
        end
    end

    get '/logout' do
        session.clear
        redirect to '/login'
    end

end
