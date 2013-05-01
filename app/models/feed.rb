class Feed < ActiveRecord::Base
  attr_accessible :etage, :feed_url, :last_modified, :title, :url
end
