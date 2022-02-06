require 'rails_helper'

RSpec.describe Order, type: :model do
  subject { Order.new( product_name: "gears", product_count: 7, customer: FactoryBot.create(:customer))}
  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end
  it "is not valid without a product name" do
    subject.product_name=nil
    expect(subject).to_not be_valid
  end
  it "is not valid without a product count" do
    subject.product_count=nil
    expect(subject).to_not be_valid
  end
  it "is not valid if the product count is 0" do
    expect(subject.product_count).to_not eq(0)
  end
  it "is not valid if the product count is not all digits" do
    expect(subject.product_name).to_not be_kind_of(Numeric)
  end
end
