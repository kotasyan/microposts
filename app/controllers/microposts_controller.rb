class MicropostsController < ApplicationController
    # ログインしていない場合は、createメソッドを実行せず/loginにリダイレクト
    before_action :logged_in_user, only: [:create]
    
    def create
        # 入力されたパラメータを元にMicropostのインスタンスを生成
        @micropost = current_user.microposts.build(micropost_params)
        # micropostの保存に成功した場合
        if @micropost.save
            flash[:success] = "Micropost created!"
            # rootにリダイレクト
            redirect_to root_url
        else
            # homeパーシャルを読み込み
            render 'static_pages/home'
        end
    end
    
    def destroy
        @micropost = current_user.microposts.find_by(id: params[:id])
        # 投稿が現在のユーザーのものでなければ、ルートに遷移
        return redirect_to root_url if @micropost.nil?
        # 投稿を削除
        @micropost.destroy
        # フラッシュメッセージを指定
        flash[:success] = "Micropost deleted"
        # 遷移元URLまたは（なければ）ルートに遷移
        redirect_to request.referrer || root_url
    end
    
    private
    def micropost_params
        # 入力されたパラメータのうち、contentのみを許可
        params.require(:micropost).permit(:content)
    end
end
