class Micropost < ActiveRecord::Base
  belongs_to :user
  # user_idが存在する   
  validates :user_id, presence: true
  # contentが存在し、文字数は最大140
  validates :content, presence: true, length: { maximum: 140 }
end
