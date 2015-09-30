class User < ActiveRecord::Base
    # データの保存前にメールアドレスのアルファベットを小文字にする。
    before_save { self.email = email.downcase }
    # nameは入力必須。最大50文字
    validates :name , presence: true, length: {maximum: 50}
    # メールアドレスの正規表現パターンを定義
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    # emailは入力必須。255文字以内でVALID_EMAIL_REGEXのパターンに一致。
    # 一意であること（大文字小文字は区別しない）
    validates :email, presence: true, length: {maximum: 255},
                      format: {with: VALID_EMAIL_REGEX},
                      uniqueness: { case_sensitive: false }

    # 認証機能を追加
    has_secure_password
    # 各ユーザーは複数の投稿を持つ
    has_many :microposts
    # ユーザーは複数のfollowing_relationshipsを持つ
    # following_relationshipsは、follwer_idを外部キーとし
    # 関連するユーザーが削除された場合、同時に削除される
    has_many :following_relationships, class_name: "Relationship",
                                       foreign_key: "follower_id",
                                       dependent: :destroy
    # ユーザーはfollowing_relationshipsのfollowed_idを介して、複数のfollowing_usersを持つ
    has_many :following_users, through: :following_relationships, source: :followed
    # ユーザーは複数のfollower_relationshipsを持つ
    # follower_relationshipsは、follower_idを外部キーとし、ユーザーが削除されたら削除
    has_many :follower_relationships, class_name: "Relationship",
                                      foreign_key: "followed_id",
                                      dependent: :destroy
    # ユーザーはfollower_relationshipsのfollower_idを介して、複数のfollower_usersを持つ
    has_many :follower_users, through: :follower_relationships, source: :follower
    
    # 他のユーザーをフォローする
    def follow(other_user)
        following_relationships.create(followed_id: other_user.id)
    end
    
    # フォローしているユーザーをアンフォローする
    def unfollow(other_user)
        following_relationships.find_by(followed_id: other_user.id).destroy
    end
    
    # あるユーザーをフォローしているかどうか？
    def following?(other_user)
        following_users.include?(other_user)
    end
end
