class TopPagesController < ApplicationController
  def home
    @most_viewed = Item.order('impressions_count DESC')
    .where("? <= created_at", Time.current.ago(3.days))
    .where("created_at <= ?", Time.current).take(20)

    @recent_item = Item.order('created_at DESC').take(20)
  end

  def contact
  end

  def search
    split_keyword = set_keyword(params[:keyword])
    n_keyword, p_keyword = split_keyword.partition {|keyword| keyword.start_with?("-") }
    sort = judge_search(params[:sort])
    @items = search_positive(p_keyword,n_keyword)
    @users = search_users(params[:keyword]).page(params[:page]).per(10)
    @i_count = @items.count
    @u_count = @users.count
    @items = @items.order(sort).page(params[:page]).per(10)
  end

  private

  def set_keyword(keyword)
    split_keyword = keyword.split(/[[:blank:]]+/).select(&:present?)
  end

  def search_positive(p_keyword,n_keyword)
    items=Item
    p_keyword.each do |keyword|
      items = items.where("title LIKE :text OR content LIKE :text", text: "%#{keyword}%")
    end
    n_keyword.each do |keyword|
      items.where!("title NOT LIKE :text OR content NOT LIKE :text", text: "%#{keyword.delete_prefix('-')}%")
    end
    return items
  end

  def search_users(keyword)
    users = User.where("name LIKE ?", "%#{keyword}%")
  end

  def judge_search(keyword)
    if keyword=="popular"
      return "impressions_count DESC"
    else
      return "created_at DESC"
    end
  end

end
