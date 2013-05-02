class Feed < ActiveRecord::Base
  attr_accessible :etag, :feed_url, :last_modified, :title, :url
  has_many :entries
  
  def fetch_feed_data (feed)
    self.etag = feed.etag
    self.feed_url = feed.feed_url
    self.url = feed.url
    self.last_modified = feed.last_modified
    self.title = feed.title
  end
  
end
