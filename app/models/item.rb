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

  def next_photo(current_photo)
    photo_in_cycle(current_photo, :next)
  end
  
  def previous_photo(current_photo)
    photo_in_cycle(current_photo, :prev)
  end
  
  private
  
  def photo_in_cycle(current_photo, direction)
    photos_attachments = photos.attachments.sort_by(&:id)
    current_index = photos_attachments.index(current_photo)
  
    new_index = case direction
                when :next
                  (current_index + 1) % photos_attachments.size
                when :prev
                  (current_index - 1) % photos_attachments.size
                else
                  current_index
                end
  
    photos_attachments[new_index]
  end
end
