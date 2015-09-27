module SessionsHelper
    # 現在のログインしているユーザーを返すメソッド
    def current_user
        # @current_userがfalseあるいはnilの場合に、現在ログインしているuserを取得
        @current_user ||= User.find_by(id: session[:user_id])
    end
    
    # ユーザーがログイン状態かどうかを返すメソッド
    def logged_in?
        # curret_userが存在する場合はtrue、存在しない場合はfalseを返す
        !!current_user
    end
    
    # アクセスしたいURLを一時保存するためのメソッド
    def store_location
        # リクエストがGETの場合は、リクエストのURLを代入
        session[:forwarding_url] = request.url if request.get?
    end
end