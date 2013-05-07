module FeedsHelper
  
  def author_and_date entry
    date = entry.created_at.strftime('at %I:%M %p %b %d, %Y ')
    if entry.author.nil?
      return date
    else
      return "by #{entry.author} "+ date
    end
  end
    
end
