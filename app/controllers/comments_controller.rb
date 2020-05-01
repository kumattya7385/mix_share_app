class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      flash[:success] = 'コメントを投稿しました!'
      redirect_to @comment.item
    else
      redirect_to item_path(id: @comment.item_id), flash: {comment: @comment, error_messages: @comment.errors.full_messages}
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
