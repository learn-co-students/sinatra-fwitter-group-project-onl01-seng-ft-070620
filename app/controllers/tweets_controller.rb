class TweetsController < ApplicationController
    get '/tweets' do
        if !current_user
            redirect '/login'
        end
        @user = User.find_by(id: session[:user_id])
        @tweets = Tweet.all
        erb :'tweets/index'
    end

    get '/tweets/new' do
        redirect_if_logged_out
        if current_user
            erb :'tweets/new'
        else
            redirect '/login'
        end
    end

    post '/tweets/new' do
        user = User.find_by(id: session[:user_id])
        user.tweets << Tweet.create(content: params[:content]) if !params[:content].empty?
    end
    
    get '/tweets/:id' do
        redirect_if_logged_out
        @tweet = Tweet.find_by(params)
        erb :'tweets/show'
    end
    
    get '/tweets/:id/edit' do
        redirect_if_logged_out
        @tweet = Tweet.find_by(params[:id])
        erb :'tweets/edit'
    end
    
    patch '/tweets/:id' do
        tweet = Tweet.find_by(id: params[:id])
        if tweet.user_id == current_user.id
            if !params[:content].empty?
                tweet.content = params[:content]
                tweet.save
            else
                redirect "/tweets/#{tweet.id}/edit"
            end
        end
        redirect "/tweets/#{tweet.id}"
    end
    
    delete '/tweets/:id' do
        
        # binding.pry
        tweet = Tweet.find_by(id: params[:id])
        if tweet.user_id == current_user.id
            tweet.delete
        end
        redirect '/tweets'
    end
end
