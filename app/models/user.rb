class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :blocks, dependent: :destroy
  has_one_attached  :photo

  def broadcast_photo_destroyed
    broadcast_replace_to(
      "photo_user_#{self.id}",
      partial: "users/photos/avatar",
      locals: { user: self },
      target: "avatar_user_#{self.id}"
    )
  end
end
