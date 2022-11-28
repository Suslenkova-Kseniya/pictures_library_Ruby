class Picture < ApplicationRecord
  validates :title, presence: true, length: {minimum: 6, maximum: 100}
  validates :description, presence: true, length: {minimum: 10, maximum: 300}
  has_many :user_pictures
  has_many :users, through: :user_pictures
end
