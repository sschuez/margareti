class Block < ApplicationRecord
  belongs_to :user
  has_many :items, dependent: :destroy

  validates :name, presence: true

  acts_as_list scope: :user

  scope :ordered, -> { order(:position) }
end
