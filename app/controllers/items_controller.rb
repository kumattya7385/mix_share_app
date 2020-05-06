class ItemsController < ApplicationController
  before_action :logged_in_user, only:[ :new, :create, :edit, :update]
  before_action :item_correct_user, only:[ :edit, :update]
  before_action :admin_or_item_user, only:[ :destroy]
  before_action :set_target_item, only: %i[show edit update destroy]

  def index
    @items = Item.page(params[:page])
  end
  
  def new
    @item = Item.new
    @tag_name_string=""
  end

  def create
    @item=current_user.items.create(item_params)
    #「#」もしくは「空白+#」を判定して配列化
    tag_list = make_tag_list(params[:tag_name])
    if @item.save
      flash[:success] = "「#{item_params[:title]}」の記事が投稿されました！"
      @item.save_tags(tag_list)
      redirect_to @item
    else
      flash[:error_messages]=@item.errors.full_messages
      @tag_name_string=params[:tag_name]
      render action: :new
    end
  end

  def show
    @comment = Comment.new(item_id: @item.id)
    @comments = @item.comments.all
    impressionist(@item, nil, :unique => [:session_hash])
  end

  def edit
    tag_set_form(@item.tags)
  end

  def update
    tag_list = make_tag_list(params[:tag_name])
    if @item.update(item_params)
      flash[:success] = "「#{@item.title}」の記事が更新されました！"
      @item.save_tags(tag_list)
      redirect_to @item
    else
      flash[:error_messages]=@item.errors.full_messages
      @tag_name_string=params[:tag_name]
      render action: :edit
    end
  end

  def destroy
    @item.destroy
    if current_user.admin?
      flash[:success] = "(管理者) 「#{@item.title}」の記事が削除されました！"
    else
      flash[:success] = "「#{@item.title}」の記事が削除されました！"
    end
    redirect_to items_path
  end

#########################################################################################
  private

  def item_params
    params.require(:item).permit(:title, :content)
  end

  def set_target_item
    @item = Item.find(params[:id])
  end

  def make_tag_list(tag_string)
    tag_string=tag_string.gsub(/( |　)+/,"")
    tag_list=tag_string.split("#")
    tag_list=tag_list.reject(&:blank?)
  end

  def tag_set_form(instance)
    if !instance.empty?
      @tag_name_string=instance.pluck(:name)
      @tag_name_string=@tag_name_string.map do |t|
        t="#"+t
      end
      @tag_name_string=@tag_name_string.join(' ')
    else
      @tag_name_string=""
    end
  end

  def item_correct_user
    unless item_user?(params[:id])
      flash[:danger]="正しいアカウントでアクセスしてください"
      redirect_to(root_url)
    end
  end

  #投稿者とログインユーザが一致するか確認
  def item_user?(item_id)
    @item=Item.find(item_id)
    @correct_user=User.find(@item.user_id)
    current_user?(@correct_user)
  end


  #管理者もしくは投稿者かどうか確認
  def admin_or_item_user
    if !current_user.admin?
      if !item_user?(params[:id])
        flash[:danger]="正しいアカウントでアクセスしてください"
        redirect_to(root_url)
      end
    end
  end
end