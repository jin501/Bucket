class UsersController < ApplicationController

  get '/' do
    if logged_in? 
      redirect to '/buckets'
    else
      erb :'/users/index'
    end
  end

  post '/signup' do
    existing_user = User.find_by(username: params[:username])
    if existing_user
      ##flash message you have an existing account, please login
      redirect to '/login'
    # elsif existing_user.class == NilClass
    else
      user = User.create(username: params[:username], password: params[:password], full_name: params[:full_name], email: params[:email])
      user.save
      session[:user_id] = user.id
      ##flash message 'new user successfully created'
      redirect '/buckets'
    # else
    #   redirect '/failure'
    end
  end

  get '/failure' do
    if logged_in?
      redirect to '/buckets'
    else
      erb :'/users/failure'
    end
  end

  get '/login' do
    if logged_in?
      redirect to '/buckets'
    else
      erb :'/users/login'
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect to '/buckets'
    else
      ##flash message "wrong credentials, please try again"
      redirect to '/login'
    end
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    if @user == nil
      redirect to '/buckets'
    elsif
      !logged_in?
      redirect to '/login'
    elsif @user == current_user && @user.buckets == []
      redirect '/buckets/new'
    elsif @user == current_user
      erb :'/users/edit_profile'
    else
      @current = current_user
      erb :'/users/profile'
    end
  end

  get '/users/:slug/edit' do
    if !logged_in?
      redirect to '/login'
    elsif logged_in? && current_user.slug == params[:slug]
      @user = current_user
      erb :'/users/edit'
    else
      redirect to '/buckets'
    end
  end

  post '/users/:slug/edit' do
    @user = current_user
    @user.full_name = params[:fullname]
    @user.save
    redirect "/users/#{@user.slug}"
  end

  get '/logout' do
    if logged_in?
      session.clear
      redirect to '/login'
    else
      redirect to '/login'
    end
  end

end