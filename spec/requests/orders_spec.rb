require 'rails_helper'

RSpec.describe "OrdersController", type: :request do
  describe "get orders_path" do
    it "renders the index view" do
      FactoryBot.create_list(:order, 10)
      get orders_path
      expect(response).to render_template(:index)
    end
  end
  describe "get order_path" do
    it "renders the :show template" do
      order = FactoryBot.create(:order)
      get order_path(order.id)
      expect(response).to render_template(:show)
    end
    it "redirects to the index path if the order id is invalid" do
      get order_path(6000) #an ID that doesn't exist
      expect(response).to redirect_to orders_path
    end
  end
  describe "get new_order_path" do
    it "renders the :new template" do
      get new_order_path
      expect(response).to render_template(:new)
    end
  end
  describe "get edit_order_path" do
    it "renders the :edit template" do
      order = FactoryBot.create(:order)
      get edit_order_path(id: order.id)
      expect(response).to render_template(:edit)
    end
  end
  describe "post orders_path with valid data" do
    it "saves a new entry and redirects to the show path for the entry" do
      customer = FactoryBot.create(:customer)
      order_attributes = FactoryBot.attributes_for(:order, customer_id: customer.id)
      expect { post orders_path, params: {order: order_attributes}
    }.to change(Order, :count)
      expect(response).to redirect_to customer_path(id: customer.id)
    end
  end

  describe "post orders_path with invalid data" do
    it "does not save a new entry or redirect" do
      customer = FactoryBot.create(:customer)
      order_attributes = FactoryBot.attributes_for(:order, customer_id: customer.id)
      order_attributes.delete(:product_name)
      expect { post orders_path, params: {order: order_attributes}
    }.to_not change(Order, :count)
      expect(response).to render_template(:new)
    end
  end
  describe "put order_path with valid data" do
    it "updates an entry and redirects to the show path for the customer" do
      order = FactoryBot.create(:order)
      put "/orders/#{Order.last.id}", params: {order: {product_count: 50}}
      byebug
      order.reload
      byebug
      expect(order.product_count).to eq(50)
      expect(response).to redirect_to("/orders/#{order.id}")
    end
  end

  #describe "put order_path with valid data" do
    #it "updates an entry and redirects to the show path for the customer" do    
      #order = Order.new(id: 1, product_name: "gears", product_count: 7, customer: FactoryBot.create(:customer))
      #order = FactoryBot.create(:order, customer: FactoryBot.create(:customer))
      #order = FactoryBot.create(:order)
      #visit order_path(order)
      #fill_in "product_name", with: "Fanta"
      #put "/orders/1", params: {order: {product_name: "fanta"}}
      #Order.last.reload
      #put "/orders/#{order.id}", params: {order: {product_name: 'Fanta'}}
      #put order_path(order.id), params: {order: {product_name: 'Fanta'}}
      #order.reload
      #byebug
      #expect{order.reload}.to change(order, :product_name).to('fanta')
      #customer = FactoryBot.create(:customer)
      #order_attributes = FactoryBot.attributes_for(:order, customer_id: customer.id)
      
      #put :update, :id => order.id, :order => order_attributes
      #order.reload
      
      
      #put order_path(id: order.id), params: {product_name: 'Oleg'}
      #order.reload
      
      
      #expect(response).to redirect_to(orders_path)
      
    #end
  #end
  describe "put order_path with invalid data" do
    it "does not update the customer record or redirect" do
      order = FactoryBot.create(:order)
      put "/orders/#{order.id}", params: {order: {customer_id: 5001}}
      order.reload
      expect(order.customer_id).to_not eq(5001)
      expect(response).to render_template(:edit)
    end
  end
  describe "delete an order record" do
    it "deletes an order record" do
      order = FactoryBot.create(:order)
      order.destroy
      expect(Order.exists?(order.id)).to be_falsey
    end
  end
end
