class Customer < ApplicationRecord
    has_many :orders, dependent: :delete_all
    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :phone,  presence: true
    validates :phone, numericality: { only_integer: true }
    validates :phone, length: { is: 10}
    validates :email, presence: true
    validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
    validates :order_id, presence: true
   
    def full_name
      "#{first_name} #{last_name}"
    end
end
