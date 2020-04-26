class SessionsController < ApplicationController
  def new
    render layout:"form"
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      if user.activated?
        log_in user
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        redirect_back_or user
      else
        message  = "アカウントがアクティベーションされていません。 "
        message += "メールのアクティベーションリンクを確認してください。"
        flash[:warning] = message
        render action: :new, layout:"form"
      end
    else
      flash.now[:danger] = 'メールアドレスもしくはパスワードが間違っています'
      render action: :new, layout:"form"
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
