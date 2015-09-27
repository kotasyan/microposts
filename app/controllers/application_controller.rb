class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  # SessionsHelperの読み込み
  include SessionsHelper
  
  private
  def logged_in_user
    # ユーザーがログインしていない場合
    unless logged_in?
      # アクセスしようとしたURLをセッションに一時保存する
      store_location
      # フラッシュメッセージに警告を表示
      flash[:danger] = "Please log in"
      # ログイン画面に遷移（リダイレクトの場合は絶対パスの'*_url'を使う）
      redirect_to login_url
    end
  end
end
