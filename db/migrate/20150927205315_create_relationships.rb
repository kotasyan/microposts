class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
      t.references :follower, index: true
      t.references :followed, index: true

      t.timestamps null: false
      
      # followerとfollowedのペアが一意となるよう複合インデックスを設定
      t.index [:follower_id, :followed_id], unique: true
    end
  end
end
