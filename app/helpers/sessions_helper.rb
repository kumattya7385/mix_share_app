module SessionsHelper
     #渡されたユーザをログイン->一時セッションに保存
     def log_in(user)
        session[:user_id]=user.id
    end

    #現在ログインしているユーザを返す関数
    def current_user

        #user_idにsession[:user_id]を代入できたらtrue
        if (user_id = session[:user_id])
            @current_user ||= User.find_by(id: user_id)
        #user_idにcookie[:user_id]を代入できたらtrue
        elsif (user_id = cookies.signed[:user_id])
            #userをDBから探す
            user = User.find_by(id: user_id)
            #remember_token
            if user && user.authenticated?(cookies[:remember_token])
                log_in user
                @current_user = user
            end
        end
    end

    #ユーザがログインしていればtrueを返す
    def logged_in?
        !current_user.nil?
    end

    #ユーザをcookieに保存する
    def remember(user)
        user.remember
        cookies.permanent.signed[:user_id] = user.id
        cookies.permanent[:remember_token] = user.remember_token
    end

    # cookieを破棄する
    def forget(user)
        #cookieをDBから削除するUserのインスタンスメソッド
        user.forget
        cookies.delete(:user_id)
        cookies.delete(:remember_token)
    end

    # 現在のユーザーがログアウトする
    def log_out
        forget(current_user)
        session.delete(:user_id)
        @current_user = nil
    end
end
