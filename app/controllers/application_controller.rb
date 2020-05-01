class ApplicationController < ActionController::Base
    include SessionsHelper

private
    #ユーザのログインを確認する
    def logged_in_user
        unless logged_in?
            store_location
            flash[:danger]="ページを表示するのにログインが必要です"
            redirect_to login_url
        end
    end
end
