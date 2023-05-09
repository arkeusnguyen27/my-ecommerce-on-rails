class CreateVote < ActiveRecord::Migration[6.1]
  def change
    create_table :votes do |t|
      t.string :react

      t.belongs_to :user
      t.belongs_to :blog

      t.timestamps
    end
  end
end
