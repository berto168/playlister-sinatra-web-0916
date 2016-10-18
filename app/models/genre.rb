# == Schema Information
#
# Table name: genres
#
#  id   :integer          not null, primary key
#  name :string
#

class Genre < ActiveRecord::Base
  has_many :song_genres
  has_many :songs, through: :song_genres
  has_many :artists, through: :songs

  def slug
    self.name.downcase.gsub(" ", "-")
  end

  def self.find_by_slug(slug)
    Genre.all.find {|genre| genre.slug == slug}
  end
end
