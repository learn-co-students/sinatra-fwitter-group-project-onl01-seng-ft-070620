class TweetsController < ApplicationController

    get '/tweets' do
        if !current_user
            redirect '/login'
        end
        @tweets = Tweet.all
        @user = User.find(session[:user_id])
        
        erb :'tweets/index'
    end

    get '/tweets/new' do
        if !current_user
            redirect '/login'
        end
        erb :'tweets/new'
    end

    post '/tweets' do
        if params[:content].empty?
            redirect 'tweets/new'
        end
        @tweet = Tweet.create(content: params[:content])
        @tweet.user  = current_user
        @tweet.save
        redirect '/tweets'
    end

    get '/tweets/:id/edit' do
        
        if logged_in?
            @tweet = Tweet.find(params[:id])
            if current_user != @tweet.user
                redirect "/tweets"
            end
        else
            redirect "/login"
        end
        erb :'tweets/edit'
    end

    delete '/tweets/:id/delete' do
        @tweet = Tweet.find(params[:id])
        if current_user != @tweet.user
            redirect "/tweets/#{@tweet.id}"
        end
        @tweet.delete
        redirect '/tweets'
    end
    
    get '/tweets/:id' do
        if !current_user
            redirect '/login'
        end
        @tweet = Tweet.find(params[:id])
        erb :'tweets/show'
    end

    patch '/tweets/:id' do
        if params[:content].empty?
            redirect "/tweets/#{params[:id]}/edit"
        end
        @tweet = Tweet.find(params[:id])
        @tweet.content = params[:content]
        @tweet.save
        redirect "/tweets/#{@tweet.id}"
    end



end
