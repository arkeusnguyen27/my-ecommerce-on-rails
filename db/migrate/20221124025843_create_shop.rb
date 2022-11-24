class CreateShop < ActiveRecord::Migration[6.0]
  def change
    create_table :shops do |t|
      t.string :name
      t.belongs_to :user, index: { unique: true }, foreign_key: true

      t.timestamps
    end
  end
end
