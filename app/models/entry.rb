class Entry < ActiveRecord::Base
  attr_accessible :author, :categories, :content, :published, :summary, :title, :url
  belongs_to :feed
  
end
