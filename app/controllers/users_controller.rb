class UsersController < ApplicationController

    #sets user var for slug methods
    get '/users/:slug' do
      @user = User.find_by_slug(params[:slug])
      erb :'users/show'
    end
  
    #display sign up form
    get '/signup' do
      if !logged_in?
        erb :'users/create_user', locals: {message: "Please sign up before you sign in"}
      else
        redirect to '/tweets'
      end
    end
  
    #process sign up form (if form isn't fully filled out, redirect to sign up - otherwise, create user and save to DB)
    post '/signup' do
      if params[:username] == "" || params[:email] == "" || params[:password] == ""
        redirect to '/signup'
      else
        @user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
        @user.save
        session[:user_id] = @user.id
        redirect to '/tweets'
      end
    end
  
    #display log in form
    get '/login' do
      if !logged_in?
        erb :'users/login'
      else
        redirect to '/tweets'
      end
    end
  
    #process log in form (add user_id to session hash)
    post '/login' do
      user = User.find_by(:username => params[:username])
      if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect to "/tweets"
      else
        redirect to '/signup'
      end
    end
  
    #log out (clear session hash)
    get '/logout' do
      if logged_in?
        session.destroy
        redirect to '/login'
      else
        redirect to '/'
      end
    end

  end