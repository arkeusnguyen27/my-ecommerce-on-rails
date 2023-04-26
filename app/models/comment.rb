class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :blog
  
  has_rich_text :content
  validates :content, presence: true

  def get_user_name
    return user.name
  end
end