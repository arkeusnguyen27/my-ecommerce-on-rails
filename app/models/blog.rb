class Blog < ApplicationRecord
   belongs_to :user
   has_rich_text :content

   def get_user_name
      return user.name
   end
end
  