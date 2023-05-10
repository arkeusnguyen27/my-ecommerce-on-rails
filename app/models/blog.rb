class Blog < ApplicationRecord
   belongs_to :user
   has_rich_text :content
   validates :content, presence: true
   has_many :comments
   has_many :votes

   def get_user_name
      return user.name
   end

   def get_user
      return user
   end

   def get_all_comments
      comments
   end

   def get_number_of_all_comments
      comments.count
   end

   def get_number_of_all_like_votes
      votes.where(react: 'like').count
   end

   def get_number_of_all_dislike_votes
      votes.where(react: 'dislike').count
   end

   def self.ransackable_attributes(auth_object = nil)
      ["content", "created_at", "id", "title", "updated_at", "user_id", "view_count"]
   end
end
  