class FeedsController < ApplicationController
  
  def index
    @feeds = Feed.all
  end
  
  def create
    url = params[:feed][:url]
    url = url.strip and url = url.gsub(/\A.*\/\//,"")
    created_feed = Feedzirra::Feed.fetch_and_parse(url)

    redirect_to :back and return if Feed.exists? url: created_feed.feed_url

    @feed = Feed.new
    @feed.url = created_feed.feed_url and @feed.title = created_feed.title
    @feed.save

    redirect_to :back
  end
  
end
