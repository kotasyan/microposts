class UsersController < ApplicationController
  def show
    # Userデータベースをidで検索
    @user = User.find(params[:id])
  end
  
  def new
    # Userインスタンスの新規作成
    @user = User.new
  end
  
  def create
    # 送信されたパラメータを元に新しいUserインスタンスを生成
    @user = User.new(user_params)
    if @user.save
      # フラッシュメッセージを指定
      flash[:success] = "Welcome to the Sample App!"
      # データベースへの保存に成功した場合、@userの詳細画面にリダイレクトする
      redirect_to @user
    else
      # データベースへの保存に失敗した場合、newテンプレートを出力
      render 'new'
    end
  end
  
  private
  
  def user_params
    # 入力パラメータとして、userのname, email, password, password_confirmationのみ許可する（受け取る）
    params.require(:user).permit(:name, :email, :password, 
                                 :password_confirmation)
  end
end
