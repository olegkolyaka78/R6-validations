class Order < ApplicationRecord
  belongs_to :customer
  validates_associated :customer
  validates :product_name, presence: true
  validates :product_count, presence: true
  validates :product_count, numericality: { only_integer: true, greater_than: 0 }
  #validates :full_name, presence: true
  validates :customer_id, presence: true
end
