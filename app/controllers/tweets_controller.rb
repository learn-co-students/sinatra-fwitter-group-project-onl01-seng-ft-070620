class TweetsController < ApplicationController


    get '/tweets' do
        if is_logged_in?
            @user = User.find_by(id: session[:user_id])
            @tweets = Tweet.all        
            erb :'tweets/index'
        else
            redirect to "/login"
        end
    end

    get '/tweets/new' do
        if is_logged_in?
            erb :'tweets/new'
        else
            redirect to '/login'
        end
    end

    post "/tweets" do
        if is_not_blank?(params)
            @tweet = Tweet.new(params)
            @tweet.user_id = session[:user_id]
            @tweet.save
            redirect to "/tweets/#{@tweet.id}"
        else
            redirect to "tweets/new"
        end
    end

    get '/tweets/:id/edit' do
        if is_logged_in?
            @tweet = Tweet.find_by(id: params[:id])
            erb :'tweets/edit'
        else
            redirect to '/login'
        end
    end

    get '/tweets/:id' do
        if is_logged_in?
            @tweet = Tweet.find_by(id: params[:id])
            erb :'tweets/show'
        else
            redirect to '/login'
        end
    end

    patch '/tweets/:id' do
        @tweet = Tweet.find_by(id: params[:id])
        if is_not_blank?(params)
            @tweet.content = params[:content]
            @tweet.save
            redirect to "/tweets/#{@tweet.id}"
        else
            redirect to "/tweets/#{@tweet.id}/edit"
        end
      end

    delete '/tweets/:id' do
        tweet = Tweet.find_by(id: params[:id])
        if tweet.user_id == current_user.id
            tweet.delete
            redirect to "/tweets"
        else
            redirect to "/tweets/#{tweet.id}"
        end
      end
end
