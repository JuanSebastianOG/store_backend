class Product < ApplicationRecord
  belongs_to :store

  validates :name, presence: true
  validates :sku, presence: true, uniqueness: { scope: :store_id}
  validates :inventory_quantity, numericality: {greater_than_or_equal_to: 0}
  validate :delivery_time_validity

  def delivery_time_validity
    inventory_updated_time.present? && !Time.parse(inventory_updated_time.to_s) rescue errors.add(:inventory_updated_time, 'is not a valid time')
  end
end
