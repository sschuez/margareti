class Post < ApplicationRecord
  belongs_to :user
  acts_as_list scope: :user

  validates :title, :body, presence: true

  scope :ordered, -> { order(position: :asc) }
  scope :published, -> { where(published: true) }

  def published_icon
    if published
      Icon.call('published')
    else
      Icon.call('unpublished')
    end
  end

  def keyword_subtitle
    subtitle.truncate(300).split(' ').join(', ') if subtitle.present?
  end

  def keyword_title
    title.split(' ').join(', ')
  end

  def keywords
    keyword_subtitle || keyword_title
  end

  def shift(direction)
    case direction
    when 'up'
      other_post = user.posts.where('position < ?', position).ordered.last
      other_post&.increment_position
      decrement_position
    when 'down'
      other_post = user.posts.where('position > ?', position).ordered.first
      other_post&.decrement_position
      increment_position
    end
  end
end
