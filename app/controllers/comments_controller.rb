class CommentsController < ApplicationController
  before_action :logged_in_user, only:[ :create]
  before_action :admin_or_comment_user, only:[ :destroy]
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
    @comment.destroy
    if current_user.admin?
      flash[:success] = "(管理者) コメントを削除しました！"
    else
      flash[:success] = "コメントを削除しました！"
    end
    redirect_to @comment.item
  end

  private

  def comment_params
    params.require(:comment).permit(:item_id, :name, :comment)
  end

  #投稿者とログインユーザが一致するか確認
  def comment_user?(comment_id)
    @comment=Comment.find(comment_id)
    @correct_user=User.find(@comment.user_id)
    current_user?(@correct_user)
  end

  def admin_or_comment_user
    @comment = Comment.find(params[:id])
    if !current_user.admin?
      if !comment_user?(params[:id])
        flash[:danger]="コメントを削除する権限がありません"
        redirect_to @comment.item
      end
    end
  end
end
