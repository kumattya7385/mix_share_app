class ItemsController < ApplicationController
  def index
    @items = Item.all
  end
  
  def new
    @item = Item.new
  end

  def create
    Item.create(item_params)
    redirect_to items_path
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    @item.update(item_params)
    redirect_to @item
  end

  def destroy
    @item = Item.find(params[:id])
    @item.delete

    redirect_to items_path
  end

  private

  def item_params
    params.require(:item).permit(:name, :title, :content)
  end
  
end