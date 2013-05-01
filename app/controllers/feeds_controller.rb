class FeedsController < ApplicationController
  
  def index
    @feeds = Feed.all
  end
  
  def create
    
    url = params[:feed][:feed_url]
    url = url.strip and url = url.gsub(/\A.*\/\//,"")
    created_feed = Feedzirra::Feed.fetch_and_parse(url)

    redirect_to :back and return if Feed.exists? feed_url: created_feed.feed_url

    @feed = Feed.new
    @feed.fetch_feed_data created_feed
    @feed.save
    redirect_to :back
  end
  
end
