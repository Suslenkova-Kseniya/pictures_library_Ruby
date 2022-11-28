class UserPicture < ApplicationRecord
  belongs_to :user
  belongs_to :picture
end
