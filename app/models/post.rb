class Post < ApplicationRecord
  belongs_to :user
  acts_as_list add_new_at: :top, top_of_list: 0
  
  validates :title, presence: true
  
  scope :ordered, -> { order(position: :asc) }
  scope :published, -> { where(published: true) }
    
  def published_icon
    if self.published
      Icon.call("published")
    else
      Icon.call("unpublished")
    end
  end
end
