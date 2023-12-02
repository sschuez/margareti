class Item < ApplicationRecord
  belongs_to :block
  has_one :user, through: :block

  validates :name, presence: true

  acts_as_list scope: :block

  scope :ordered, -> { order(:position) }
end
