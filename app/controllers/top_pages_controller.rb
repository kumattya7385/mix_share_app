class TopPagesController < ApplicationController
  def home
    @most_viewed = Item.order('impressions_count DESC')
    .where("? <= created_at", Time.current.ago(3.days))
    .where("created_at <= ?", Time.current).take(20)

    @recent_item = Item.order('created_at DESC').take(20)
  end

  def contact
  end
end
