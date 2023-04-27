class Store < ApplicationRecord
  has_many :products, dependent: :destroy

  validates :name, presence: true
  validates :url, presence: true
end
