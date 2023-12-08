class Post < ApplicationRecord
  belongs_to :user
  # acts_as_list add_new_at: :top, top_of_list: 0, scope: :user
  acts_as_list scope: :user
  
  validates :title, :body, presence: true
  
  scope :ordered, -> { order(position: :asc) }
  scope :published, -> { where(published: true) }
    
  def published_icon
    if self.published
      Icon.call("published")
    else
      Icon.call("unpublished")
    end
  end

  def keyword_subtitle
    subtitle.truncate(300).split(" ").join(", ") if subtitle.present?
  end
    
  def keyword_title
    title.split(" ").join(", ")
  end
    
  def keywords
    keyword_subtitle || keyword_title
  end
end
