class UsersController < ApplicationController
  before_action :logged_in_user, only:[ :edit, :update, :index, :destroy]
  before_action :correct_user, only:[ :edit, :update]
  before_action :admin_user, only: :destroy
  
  def index
    @users = User.where(activated: true).paginate(page: params[:page], per_page: 30)
  end
  
  def new
    @user=User.new
    render layout: "form"
  end

  def show
    @user=User.find(params[:id])
    redirect_to root_url and return unless @user.activated?
  end

  def create
    @user=User.new(user_params)
    if @user.save
      @user.send_activation_email
      flash[:info] = "メールを送信しました。チェックしてアクティベーションしてください"
      redirect_to root_url
    else
      render action: :new, layout: "form"
    end
  end

  def edit
    @user=User.find(params[:id])
  end
  
  def update
    @user=User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "プロファイルを更新しました"
      redirect_to @user
    else
      render action: :edit
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "アカウントを削除しました"
    redirect_to users_url
  end

  private
    def user_params
      params.require(:user).permit(:name,:email,:password,:password_confirmation)
    end


######  beforeアクション
######　保護ページや管理者権限を扱うメソッド
    #保護ページにアクセスするユーザが正しいか確認するメソッド
    def correct_user
      @user=User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    #管理者かどうかを確認する
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
