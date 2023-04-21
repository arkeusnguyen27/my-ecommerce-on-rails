class Blog < ApplicationRecord
   belongs_to :user
   has_rich_text :content
   validates :content, presence: true

   def get_user_name
      return user.name
   end
end
  