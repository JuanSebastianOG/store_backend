class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.string :name
      t.integer :sku
      t.integer :inventory_quantity
      t.time :inventory_updated_time
      t.integer :store_id

      t.timestamps
    end
  end
end
