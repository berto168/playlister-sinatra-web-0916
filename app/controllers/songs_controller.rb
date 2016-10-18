require 'rack-flash'

class SongsController < ApplicationController
  use Rack::Flash
  set :views, Proc.new { File.join(root, "../views/songs") }

  get '/songs' do
    @songs = Song.all
    erb :'index.html'
  end

  get '/songs/new' do
    erb :'new.html'
  end

  post '/songs/new' do
    artist = Artist.find_or_create_by(name: params[:artist])
    song = Song.find_or_create_by(name: params[:name], artist: artist)
    song.genre_ids = params[:genres]
    song.save
    flash[:message] = "Successfully created song."
    redirect to "/songs/#{song.slug}"
  end

  get '/songs/:slug/edit' do
    @song = Song.find_by_slug(params[:slug])
    erb :'edit.html'
  end

  get '/songs/:slug' do
    @song = Song.find_by_slug(params[:slug])
    erb :'show.html'
  end

  patch '/songs/:slug' do
    @song = Song.find_by_slug(params[:slug])
    artist = Artist.find_or_create_by(name: params[:artist])
    @song.genre_ids = params[:genres]
    @song.update(name: params[:name], artist: artist)
    flash[:message] = "Successfully updated song."
    redirect to "/songs/#{@song.slug}"
  end
end
