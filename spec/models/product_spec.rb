require './spec/rails_helper.rb'

RSpec.describe Product, type: :model do
  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:sku) }
    it { should validate_uniqueness_of(:sku).scoped_to(:store_id) }
    it { should validate_numericality_of(:inventory_quantity).is_greater_than_or_equal_to(0) }
  end

  describe "associations" do
    it { should belong_to(:store) }
  end
end