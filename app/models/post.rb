class Post < ApplicationRecord
  belongs_to :user
  has_many :likes
  has_many :like_by_user ,through: :likes, source: :user

end
