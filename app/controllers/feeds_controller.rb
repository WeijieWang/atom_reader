class FeedsController < ApplicationController
  
  def index
    @feeds = Feed.all
    @entries = Entry.order("published DESC").all
  end
  
  def create
    
    url = params[:feed][:feed_url]
    url = url.strip and url = url.gsub(/\A.*\/\//,"")
    created_feed = Feedzirra::Feed.fetch_and_parse(url)

    redirect_to :back and return if Feed.exists? feed_url: created_feed.feed_url

    @feed = Feed.new
    @feed.fetch_feed_data created_feed 
    @feed.save
    @feed.first_update_entries created_feed
    redirect_to :back
  end
  
  def show
    id = params[:q]
    feed = Feed.find_by_id(id)
    feed.update_entries
    
    @entries = feed.entries
    @feeds = Feed.all
    render :index
  end
  
end
