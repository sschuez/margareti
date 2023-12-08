class Item < ApplicationRecord
  belongs_to :block
  has_one :user, through: :block
  has_many_attached :photos

  validates :name, presence: true

  acts_as_list scope: :block

  scope :ordered, -> { order(:position) }

  def has_content?
    content.present? || photos.attached?
  end
end
