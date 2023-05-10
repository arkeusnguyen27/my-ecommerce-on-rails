class Reply < ApplicationRecord
  belongs_to :user
  belongs_to :comment
  
  has_rich_text :content
  validates :content, presence: true

  def get_user_name
    return user.name
  end

  def get_user
    return user
  end
end