class Block < ApplicationRecord
  belongs_to :user
  has_many :items, dependent: :destroy

  validates :name, presence: true

  # include RankedModel
  # ranks :row_order, with_same: :user_id
  acts_as_list scope: :user

  # scope :ordered, -> { rank(:row_order) }
  scope :ordered, -> { order(:position) }
end
