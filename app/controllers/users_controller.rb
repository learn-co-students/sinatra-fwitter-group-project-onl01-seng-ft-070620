class UsersController < ApplicationController

    get '/users/:slug' do
        @user = User.find_by_slug(params[:slug])
        erb :'users/show'
    end

    get '/signup' do
        if logged_in?
            redirect to "/tweets"
        else
            erb :'users/create_user'
        end
    end

    post '/signup' do
        if params[:username] == "" || params[:password] == "" || params[:email] == ""
            flash[:message] = "Whoops, looks like you had a blank input there. Please try again."

            redirect '/signup'
        else
            @user = User.create(username: params[:username], email: params[:email], password: params[:password])
            session[:user_id] = @user.id
            redirect '/tweets'
        end
    end

    get '/login' do
        if logged_in?
            @user = current_user
            session[:user_id] = @user.id
            redirect to "/tweets"
        else
            erb :'users/login'
        end
    end

    post "/login" do
		user = User.find_by(:username => params[:username])
 
		if user && user.authenticate(params[:password])
		  session[:user_id] = user.id
		  redirect to "/tweets"
        else
            flash[:message] = "Whoops, looks like your credentials didn't match."    
            
            redirect to "/signup"
		end
    end

    get '/logout' do
        if logged_in?
            session.destroy
            redirect to '/login'
        else
            redirect to '/'
        end
    end
end
