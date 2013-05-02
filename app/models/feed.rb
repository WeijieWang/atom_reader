class Feed < ActiveRecord::Base
  attr_accessible :etag, :feed_url, :last_modified, :title, :url
  has_many :entries, :dependent => :destroy
  def fetch_feed_data (feed)
    self.etag = feed.etag
    self.feed_url = feed.feed_url
    self.url = feed.url
    self.last_modified = feed.last_modified
    self.title = feed.title
  end

  def first_update_entries (feed)
    feed.entries.each do |rawfeed|
      self.create_entries rawfeed
    end

  end

  def update_entries
    feed_to_update = Feedzirra::Parser::AtomFeedBurner.new
    feed_to_update.feed_url = self.feed_url
    feed_to_update.etag = self.etag
    feed_to_update.last_modified = self.last_modified
    last_entry = self.entries.last
    feed_to_update.entries = [last_entry]

    updated_feed = Feedzirra::Feed.update(feed_to_update)

    if updated_feed.updated?
      updated_feed.new_entries.each do |rawfeed|
        self.create_entries rawfeed
      end
    end

  end

  protected

  def create_entries rawfeed
    self.entries.create(title: rawfeed.title, summary: rawfeed.summary,
    author: rawfeed.author, categories: rawfeed.categories.to_s,
    content: rawfeed.content, published: rawfeed.published, url: rawfeed.url,
    guid: rawfeed.id)
  end

end
