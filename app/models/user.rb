class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :blocks, dependent: :destroy
  has_many :items, through: :blocks
  has_many :posts, dependent: :destroy
  has_one_attached :photo

  # For the name function, to use markdown_helpers
  include MarkdownHelper
  include ActionView::Helpers

  def broadcast_photo_destroyed
    broadcast_replace_to(
      "photo_user_#{id}",
      partial: 'users/photos/avatar',
      locals: { user: self },
      target: "avatar_user_#{id}"
    )
  end

  def name
    full_name.present? ? markdown_links_to_html(full_name) : email_username
  end

  # For pundit
  def user
    self
  end

  def email_username
    email.split('@').first
  end
end
