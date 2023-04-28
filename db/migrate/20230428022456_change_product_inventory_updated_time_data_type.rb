class ChangeProductInventoryUpdatedTimeDataType < ActiveRecord::Migration[6.1]
  def change
    change_column :products, :inventory_updated_time, :datetime
  end
end
