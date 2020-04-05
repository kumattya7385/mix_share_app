class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      store_location
      log_in user
      remember user
      redirect_back_or user
    else
      flash.now[:danger] = 'メールアドレスもしくはパスワードが間違っています'
      render action: :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
