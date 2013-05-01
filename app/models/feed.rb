class Feed < ActiveRecord::Base
  attr_accessible :etag, :feed_url, :last_modified, :title, :url
  
  def fetch_feed_data (feed)
    etag = feed.etag
    feed_url = feed.feed_url
    url = feed.url
    last_modified = feed.last_modified
    title = feed.title
  end
end
