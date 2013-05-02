class Entry < ActiveRecord::Base
  attr_accessible :author, :categories, :content, :published, :summary, :title, :url, :guid
  belongs_to :feed
  validates_uniqueness_of :url, :scope => :feed_id
  validates_uniqueness_of :guid, :scope => :feed_id
end
