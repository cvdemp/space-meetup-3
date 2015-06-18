require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/flash'
require 'omniauth-github'
require 'pry'

require_relative 'config/application'

enable :sessions

Dir['app/**/*.rb'].each { |file| require_relative file }

helpers do
  def current_user
    user_id = session[:user_id]
    @current_user ||= User.find(user_id) if user_id.present?
  end

  def signed_in?
    current_user.present?
  end
end

def set_current_user(user)
  session[:user_id] = user.id
end

def authenticate!
  unless signed_in?
    flash[:notice] = 'You need to sign in if you want to do that!'
    redirect '/'
  end
end

get '/' do
  meetups = Meetup.order(:title)
  erb :index, locals: { meetups: meetups }
end

get '/auth/github/callback' do
  auth = env['omniauth.auth']

  user = User.find_or_create_from_omniauth(auth)
  set_current_user(user)
  flash[:notice] = "You're now signed in as #{user.username}!"

  redirect '/'
end

get '/sign_out' do
  session[:user_id] = nil
  flash[:notice] = "You have been signed out."

  redirect '/'
end

get '/example_protected_page' do
  authenticate!
end

get '/:id' do
  id = params["id"]
  meetup = Meetup.find(id)
  attendees = Attendee.where(meetup_id: id)

  erb :show, locals: { meetup: meetup, attendees: attendees }
end

post '/' do
  meetup = Meetup.new(title: params["title"], description: params["description"], location: params["location"])
  if signed_in?
    flash[:notice] = "Meetup saved!"
    meetup.save
    Attendee.create(meetup_id: meetup.id, user_id: current_user.id, owner: true)
    redirect "/#{meetup.id}"
  else
    flash[:notice] = "You must be signed in to do that!"
    redirect '/'
  end
end

post '/:id' do
  id = params["id"]
  meetup = Meetup.find(id)
  attendees = Attendee.where(meetup_id: id)
  new_attendee = Attendee.new(meetup_id: meetup.id, user_id: current_user.id, owner: false)

  if signed_in?
    attendees.each do |attendee|
      if Attendee.where(meetup_id: meetup.id, user_id: current_user.id, owner: false).first == nil
      flash[:notice] = "You're in!"
      new_attendee.save
        redirect "/#{meetup.id}"
      else
        flash[:notice] = "You are already signed up!"
      end
    end
  else
    flash[:notice] = "You must be signed in to do that!"
    redirect '/'
  end
  erb :show, locals: { meetup: meetup, attendees: attendees }
end
