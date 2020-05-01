class ItemsController < ApplicationController
  before_action :set_target_item, only: %i[show edit update destroy]
  def index
    @items = Item.page(params[:page])
  end
  
  def new
    @item = Item.new
    @tag_name_string=""
  end

  def create
    @item=Item.new(item_params)
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
    flash[:success] = "「#{@item.title}」の記事が削除されました！"
    redirect_to items_path
  end

  private

  def item_params
    params.require(:item).permit(:name, :title, :content)
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
  
end