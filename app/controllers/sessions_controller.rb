class SessionsController < ApplicationController
  def new
  end
  
  def create
    # 入力されたメールアドレス（小文字化）でUserデータベースを検索
    @user = User.find_by(email: params[:session][:email].downcase)
    # @userが見つかり、かつ、パスワードが正しい場合
    if @user && @user.authenticate(params[:session][:password])
      # sessionのuser_idに入力されたidを保存
      session[:user_id] = @user.id
      # フラッシュメッセージを表示
      flash[:info] = "logged in as #{@user.name}"
      # @userのページを表示
      redirect_to @user
    # @userが見つからない、あるいは、パスワードが正しくない場合
    else
      # エラーメッセージを表示
      flash[:danger] = 'invalid email/password combination'
      # newテンプレートを表示
      render 'new'
    end
  end
  
  def destroy
    # sessionに保存されたuser_idを破棄する
    session[:user_id] = nil
    # rootに遷移
    redirect_to root_path
  end
  
end
