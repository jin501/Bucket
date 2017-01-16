class BucketsController < ApplicationController

  get '/buckets' do
    if logged_in?
      @user = current_user
      @buckets = Bucket.all
      erb :'buckets/buckets'
    else
      ##flash message: "please log in first"
      redirect '/login'
    end
  end

  get '/buckets/new' do
    if logged_in?
      @user = current_user
      erb :'buckets/new'
    else
      redirect '/login'
    end
  end

  post '/buckets/new' do
    @user = current_user
    @bucket = @user.buckets.create(title: params[:title], user_id: session[:user_id] )
    params[:element].each do |c|
      Element.create(content: c[:content])
      if c[:content] != ""
        @bucket.elements.create(content: c[:content])
        binding.pry
      end
    end
    # @topic = Topic.create(hashtag: params[:topic])
    @bucket.save
    redirect to "/buckets/#{@bucket.id}"
  end

  get '/buckets/:id' do
    @bucket = Bucket.find_by_id(params[:id])
    if !logged_in? 
      redirect '/login'
    elsif @bucket == nil
      redirect '/buckets'
    else
      @current = current_user
      @user = @bucket.user
      erb :'buckets/view'
    end
  end

  get '/buckets/:id/edit' do
    @bucket = Bucket.find_by_id(params[:id])
    if !logged_in?
      redirect '/login'
    elsif @bucket == nil
      redirect "/buckets"
    elsif @bucket.user == current_user
      @user = current_user
      erb :'buckets/edit'
    else
      redirect "/buckets/#{@bucket.id}"
    end
  end

  post '/buckets/:id/edit' do
    @bucket = Bucket.find(params[:id])
    @user = @bucket.user
    @bucket.title = params[:title]
    params[:element].each do |c|
      if c[:content] == ""
      else
        @element = Element.find_or_create_by(content: c[:content])
        @element.update(bucket_id: @bucket.id, user_id: session[:user_id])
        @bucket.elements << @element
        @element.save
      end
    end
    @bucket.save
    redirect "/buckets/#{@bucket.id}"
  end

  post '/buckets/:id/delete' do
    @bucket = Bucket.find(params[:id])
    if @bucket.user == current_user
      @bucket.destroy
    end
    @user = current_user
    redirect "/users/#{@user.slug}"
  end

##########################check below

  get '/buckets/:id/element/:id' do
    if !logged_in?
      redirect '/login'
    else
      @bucket = Bucket.find(params[:captures][0])
      @element = Element.find(params[:id])
      @user = @bucket.user
      @current = current_user
      erb :'buckets/elements/element'
    end
  end

  get '/buckets/:id/element/:id/edit' do
    if !logged_in?
      redirect '/login'
    else
      @bucket = Bucket.find(params[:captures][0])
      @element = Element.find(params[:id])
      @user = @bucket.user
      @current = current_user
      if @user == current_user
        erb :'buckets/elements/edit_element'
      else
        erb :'buckets/elements/element'
      end
    end
  end

  post '/buckets/:id/element/:id/edit' do
    @bucket = Bucket.find(params[:captures][0])
    @element = Element.find(params[:id])
    @bucket.user = current_user
    @element.posts.clear << Post.create(blob: params[:blob])
    @element.save
    redirect to "/buckets/#{@bucket.id}/element/#{@element.id}"
  end

end