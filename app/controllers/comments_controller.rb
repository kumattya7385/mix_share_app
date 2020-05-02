class CommentsController < ApplicationController
  before_action :logged_in_user, only:[ :create]
  def create
    @comment = current_user.comments.create(comment_params)
    @item=Item.find(@comment.item_id)
    @comments = @item.comments.all
    if @comment.save
      flash[:success] = 'コメントを投稿しました!'
      redirect_to @comment.item
    else
      flash[:error_messages]=@comment.errors.full_messages
      @item=Item.find(@comment.item_id)
      render template: "items/show"
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.delete
    redirect_to @comment.item,flash: {success: 'コメントが削除されました'}
  end

  private

  def comment_params
    params.require(:comment).permit(:item_id, :name, :comment)
  end
end
