class Blog < ApplicationRecord
   belongs_to :user
   has_rich_text :content
   validates :content, presence: true
   has_many :comments

   def get_user_name
      return user.name
   end

   def get_all_comments
      comments
   end

   def get_number_of_all_comments
      comments.count
   end
end
  