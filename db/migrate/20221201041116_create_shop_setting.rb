class CreateShopSetting < ActiveRecord::Migration[6.0]
  def change
    create_table :shop_settings do |t|
      t.belongs_to :shop
      t.column :featured_products, :bigint, array: true

      t.timestamps
    end
  end
end
