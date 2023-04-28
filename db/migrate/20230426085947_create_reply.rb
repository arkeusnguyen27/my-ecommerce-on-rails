class CreateReply < ActiveRecord::Migration[6.1]
  def change
    create_table :replies do |t|
      t.text :content
      t.belongs_to :user
      t.belongs_to :blog

      t.timestamps
    end
  end
end
