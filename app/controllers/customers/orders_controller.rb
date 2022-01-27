module Customers
    class OrdersController
      # GET /customers/:customer_id/orders
      def index
        @customer = Customer.includes(:orders).find(params[:customer_id])
        @orders = @customer.orders
      end
    end
  end