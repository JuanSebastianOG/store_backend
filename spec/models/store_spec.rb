require './spec/rails_helper.rb'

RSpec.describe Store, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:url) }
  end

  describe 'associations' do
    it { should have_many(:products).dependent(:destroy) }
  end
end