class StaticPagesController < ApplicationController
  def home
    # ログインユーザーの場合、投稿のインスタンスを生成(user_idが紐付いている)
    @micropost = current_user.microposts.build if logged_in?
  end
end
