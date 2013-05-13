class Feed < ActiveRecord::Base
  
  attr_accessible :etag, :feed_url, :last_modified, :title, :url
  has_many :entries, :dependent => :destroy
  
  def fetch_feed_data (feed)
    self.etag = feed.etag
    self.feed_url = feed.feed_url
    self.url = feed.url
    self.title = feed.title
    self.last_modified = feed.last_modified
    return
  end

  def first_update_entries (feed)
    feed.entries.each do |rawfeed|
      self.create_entries rawfeed
    end

  end

  def self.update_all_entries
    Feed.all.each do |feed|
      feed.update_entries
    end

  end

  def update_entries
=begin
feed_to_update = Feedzirra::Parser::Atom.new
feed_to_update.feed_url = self.feed_url
feed_to_update.etag = self.etag
feed_to_update.last_modified = self.last_modified
last_entry = Feedzirra::Parser::AtomEntry.new
last_entry.url = self.entries.order("published DESC").first.url
feed_to_update.entries = [last_entry]

updated_feed = Feedzirra::Feed.update(feed_to_update)
return if updated_feed.nil?

if updated_feed.updated?
self.update_attributes(etag: updated_feed.etag, last_modified: updated_feed.last_modified)
end

updated_feed.new_entries.each do |rawfeed|
self.create_entries rawfeed
end
=end
    feed = Feedzirra::Feed.fetch_and_parse(self.feed_url)
    self.update_attributes(etag: feed.etag, last_modified: feed.last_modified)
    feed.entries.each do |rawfeed|
      self.create_entries rawfeed unless self.entries.exists? :guid => rawfeed.id
    end

  end

  def self.clear_entries
    Entry.where("created_at < ?", Time.now).delete_all
  #Feed.all.each {|e| e.first_update_entries if e.entries.count == 0 }
  end

  protected

  #categories: rawfeed.categories.to_s,
  def create_entries rawfeed
    self.entries.create(title: rawfeed.title[0..254], summary: rawfeed.summary,
    author: rawfeed.author, content: rawfeed.content, published: rawfeed.published, 
    url: rawfeed.url, guid: rawfeed.id)
  end

end
