class OrdersController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :catch_not_found
  before_action :set_customer, only: %i[ show edit update destroy ]
  layout 'order_layout'

  # GET /orders or /orders.json
  def index
    @orders = Order.all
    #@orders = @customer.orders
  end

  # GET /orders/1 or /orders/1.json
  def show
    @order = Order.find(params[:id])
  end

  # GET /orders/new
  def new
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
    @order = Order.find(params[:id])
  end

  # POST /orders or /orders.json
  def create
    @customer = Customer.find(params[:customer_id])
    @order = @customer.orders.create(order_params)
    #if @order.save
      #flash.notice = "The order record was created successfully."
      redirect_to @customer
    #else
      #flash.now.alert = @order.errors.full_messages.to_sentence
      #render :new  
    #end
  end

  # PATCH/PUT /customers/1 or /customers/1.json
  def update
    #@customer = Customer.find(params[:customer_id])
    @order = Order.find(params[:id])
    @order.update(order_params)
    if @order.update(order_params)
      flash.notice = "The customer record was updated successfully."
      redirect_to @customer
    else
      flash.now.alert = @order.errors.full_messages.to_sentence
      render :edit
    end
  end

  # DELETE /orders/1 or /orders/1.json
  def destroy
    #@customer = Customer.find(params[:customer_id])
    #@order = Order.find(params[:id])
    @order = @customer.orders.find(params[:id])
    @order.destroy
    redirect_to customer_path(@customer)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_customer
      @customer = Customer.find(params[:customer_id])
    end

    # Only allow a list of trusted parameters through.
    def order_params
      params.require(:order).permit(:product_name, :product_count)
    end

    def catch_not_found(e)
      Rails.logger.debug("We had a not found exception.")
      flash.alert = e.to_s
      redirect_to orders_path
    end

end
