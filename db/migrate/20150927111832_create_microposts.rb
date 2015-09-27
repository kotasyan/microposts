class CreateMicroposts < ActiveRecord::Migration
  def change
    create_table :microposts do |t|
      # user_idを外部キーとしてインデックスを追加、外部キー制約あり
      t.references :user, index: true, foreign_key: true
      t.text :content

      t.timestamps null: false
      
      # ユーザーの投稿を作成時間で並び替える処理の高速化のため、複合インデックス作成
      t.index [:user_id, :created_at]
    end
  end
end
