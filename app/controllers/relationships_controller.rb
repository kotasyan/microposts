class RelationshipsController < ApplicationController
    before_action :logged_in_user
    
    # フォローする
    def create
        @user = User.find(params[:followed_id])
        current_user.follow(@user)
    end
    
    # アンフォローする
    def destroy
        # 現在のユーザーのfollowing_relationshipsを検索して、フォローされているユーザーを取得
        @user = current_user.following_relationships.find(params[:id]).followed
        current_user.unfollow(@user)
    end
end
