class TweetsController < ApplicationController
    get '/tweets' do
        if logged_in? 
            # @user = current_user
            @tweets = Tweet.all
            erb :'tweets/tweets'
        else
            redirect '/login'
        end
    end

    get '/tweets/new' do
        # binding.pry
        if logged_in?
            erb :'tweets/new'
        else 
            flash[:message] = "You Must Be Logged in to Make Tweets"
            redirect '/login'
        end
    end

    post '/tweets' do
        if current_user.id == session[:user_id] #logged_in?
          if params[:content] == ""
            redirect to "/tweets/new"
          else
            @tweet = current_user.tweets.build(content: params[:content])
            if @tweet.save
              redirect to "/tweets/#{@tweet.id}"
            else
              redirect to "/tweets/new"
            end
          end
        else
          redirect to '/login'
        end
      end

    # post '/tweets' do
    #     if current_user.id == session[:user_id]
    #         @tweet = Tweet.create(content: params[:content])
    #         # session[:user_id] = @user.id
    #         redirect '/tweets'
    #     else
    #         redirect '/'
    #     end
    # end

    get '/tweets/:id' do
        if logged_in?
        # binding.pry
            @tweet = Tweet.find(params[:id])
            erb :'/tweets/show_tweet'
        else
            redirect to '/login'
        end
    end

    get '/tweets/:id/edit' do
        if logged_in?
            binding.pry
            @tweet = Tweet.find_by_id(params[:id])
            if @tweet && @tweet.user == current_user
                erb :'tweets/edit_tweet'
            else
                redirect to '/tweets'
            end
        else 
            redirect to '/login'
        end
    end

    patch '/tweets/:id' do
        if current_user.id == session[:user_id] #logged_in?
            if params[:content] == ""
                flash[:message] = "Whoops, looks like your tweet is blank."
                redirect to "/tweets/#{params[:id]}/edit"
            else
                @tweet = Tweet.find_by(params[:id])
                if @tweet && @tweet.user == current_user
                    if @tweet.update(content: params[:content])
                        redirect to "/tweets/#{@tweet.id}"
                    else
                        redirect to "/tweets/#{@tweet.id}/edit"
                    end
                else 
                    redirect '/tweets'
                end
            end
        else 
            redirect '/login'
        end
    end

    delete '/tweets/:id/delete' do
        if logged_in?
            @tweet = Tweet.find_by(params[:id])
            if @tweet && @tweet.user == current_user
                @tweet.delete
            end
            redirect to '/tweets'
        else
            redirect '/login'
        end
    end
end
