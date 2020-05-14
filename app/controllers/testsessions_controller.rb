class TestsessionsController < ApplicationController
  def create
    user=User.find_by(email:"testuser@vmish.com")
    log_in(user)
    flash[:success] = "テストユーザとしてログインしました。"
    redirect_to user
  end
  
end
