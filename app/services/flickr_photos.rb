require 'flickraw'
class FlickrPhotos

  def initialize
    FlickRaw.api_key =       ENV['FLICKR_KEY']
    FlickRaw.shared_secret = ENV['FLICKR_SECRET']
  end

  def get_photos(numbers)
    photos = flickr.photos.getRecent :per_page => numbers, :page => 1
    photos.map do |photo|
      make_url(photo)
    end
  end

private
  def make_url(photo)
    "https://farm#{photo.farm}.staticflickr.com/#{photo.server}/#{photo.id}_#{photo.secret}.jpg"
  end
end
