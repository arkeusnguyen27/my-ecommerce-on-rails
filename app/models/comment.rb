class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :blog
  
  has_rich_text :content
  validates :content, presence: true
  has_many :replies

  def get_user_name
    return user.name
  end

  def get_all_replies
    replies
  end

  def get_user
    return user
  end

end