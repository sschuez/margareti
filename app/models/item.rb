class Item < ApplicationRecord
  belongs_to :block

  validates :name, presence: true

  # include RankedModel
  # ranks :row_order, with_same: :block_id
  acts_as_list scope: :block

  # scope :ordered, -> { rank(:row_order) }
  scope :ordered, -> { order(:position) }
end
