class TweetsController < ApplicationController

    get '/tweets' do
        redirect '/login' if !logged_in?
        @tweets = Tweet.all
        erb :'tweets/index'
    end

    get '/tweets/new' do
        redirect '/login' if !logged_in?
        erb :'tweets/new'
    end

    post '/tweets' do
        tweet = Tweet.create(params)
        if tweet.valid?
            tweet.user = current_user
            tweet.save
        else
            redirect '/tweets/new'
        end
    end

    get '/tweets/:id' do
        redirect '/login' if !logged_in?
        @tweet = Tweet.find_by(id: params[:id])
        erb :'tweets/show'
    end

    get "/tweets/:id/edit" do
        redirect '/login' if !logged_in?
        @tweet = Tweet.find_by(id: params[:id])
        erb :'tweets/edit'
    end

    patch '/tweets/:id' do
        tweet = Tweet.find_by(id: params[:id])
        if tweet.user != current_user || params[:content].empty?
            redirect "/tweets/#{tweet.id}/edit"
        else
            tweet.update(content: params[:content])
            redirect '/tweets'
        end
    end

    delete '/tweets/:id' do
        tweet = Tweet.find_by(id: params[:id])
        if tweet.user == current_user
            tweet.delete
        end
        redirect '/tweets'
    end
end
