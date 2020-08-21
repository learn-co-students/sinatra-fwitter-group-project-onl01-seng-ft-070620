class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      erb :'/tweets/tweets'
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do
    if logged_in? && current_user.id == session[:user_id]
      erb :'/tweets/new'
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    if !params[:content].empty?
      @tweet = Tweet.create(content: params[:content], user: current_user)
      redirect '/tweets'
    else
      redirect '/tweets/new'
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      erb :'/tweets/show_tweet'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?

      @tweet = Tweet.find_by_id(params[:id])
      if @tweet && @tweet.user == current_user
        erb :'/tweets/edit_tweet'
      else
        redirect '/tweets'
      end

    else
      redirect '/login'
    end
  end

  patch '/tweets/:id' do
    if !params[:content].empty?
      @tweet = Tweet.find_by_id(params[:id])
      @tweet.update(content: params[:content])
      redirect '/tweets'
    else
      redirect "/tweets/#{params[:id]}/edit"
    end
  end

  delete '/tweets/:id/delete' do
    if logged_in?

      tweet = Tweet.find_by_id(params[:id])
      if tweet and tweet.user == current_user
        tweet.destroy
      end
      redirect '/tweets'

    else
      redirect '/login'
    end
  end

end
