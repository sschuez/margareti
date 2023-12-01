class Item < ApplicationRecord
  belongs_to :block

  validates :name, presence: true
end
