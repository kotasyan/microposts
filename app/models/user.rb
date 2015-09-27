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
end
