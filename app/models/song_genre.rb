# == Schema Information
#
# Table name: song_genres
#
#  id       :integer          not null, primary key
#  song_id  :integer
#  genre_id :integer
#

class SongGenre < ActiveRecord::Base
  belongs_to :genre
  belongs_to :song
end
