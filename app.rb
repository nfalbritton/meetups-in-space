require 'sinatra'
require_relative 'config/application'

set :bind, '0.0.0.0'  # bind to all interfaces

helpers do
  def current_user
    if @current_user.nil? && session[:user_id]
      @current_user = User.find_by(id: session[:user_id])
      session[:user_id] = nil unless @current_user
    end
    @current_user
  end
end

get '/' do
  redirect '/meetups'
end

get '/auth/github/callback' do
  user = User.find_or_create_from_omniauth(env['omniauth.auth'])
  session[:user_id] = user.id
  flash[:notice] = "You're now signed in as #{user.username}!"

  redirect '/'
end

get '/sign_out' do
  session[:user_id] = nil
  flash[:notice] = "You have been signed out."

  redirect '/'
end

get '/meetups' do
  @meetups = Meetup.all
  erb :'meetups/index'
end

get '/meetups/:id' do
  id = params[:id]
  @info = Meetup.find(id)
  @participants = Attendee.where(meetup_id: id)
  erb :'meetups/participants'
end

post '/meetups/:id' do
  if session[:user_id].nil?
    flash[:notice] = "Sign in to attend this meetup"
  else
    Participant.create(user_id: session[:user_id], meetup_id: params[:meetup_id])
    flase[:notice] = "You are attending this meetup"
  end
  redirect "/meetups/#{params[:id]}"
end

get '/create' do
  erb :'meetups/create'
end

post '/create' do
  Meetup.create(name: params[:name], date: params[:date],
  time: params[:time],
  location: params[:location],
  description: params[:description],
  email: params[:email],
  creator_user_id: session[:user_id])
  redirect '/meetups'
end
