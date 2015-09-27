class UsersController < ApplicationController
  # edit, updateアクションの前に、set_userメソッドを実行
  before_action :set_user, only: [:show, :edit, :update]
  
  def show
    # ログインユーザーの投稿を取得
    @microposts = @user.microposts
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
  
  def edit
  end
  
  def update
    if @user.update(profile_params)
      flash[:success] = "Your Profile is updated!"
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  private
  
  def user_params
    # 入力パラメータとして、userのname, email, password, password_confirmationのみ許可する（受け取る）
    params.require(:user).permit(:name, :email, :password, 
                                 :password_confirmation)
  end
  
  def profile_params
    params.require(:user).permit(:name, :email, :profile, :location)
  end
  
  def set_user
    # Userデータベースをidで検索
    @user = User.find(params[:id])
  end
end
