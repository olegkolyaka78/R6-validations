class OrdersController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :catch_not_found
  before_action :set_customer, only: [ :update, :create ]
  layout 'order_layout'

  # GET /orders or /orders.json
  def index
    @orders = Order.all
    render :index
  end

  # GET /orders/1 or /orders/1.json
  def show
    @order = Order.find(params[:id])
    render :show
  end

  # GET /orders/new
  def new
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
    @order = Order.find(params[:id])
    render :edit
  end

  # POST /orders or /orders.json
  def create
    @order = @customer.orders.new(order_params)
    if @order.save
      flash.notice = "The order record was created successfully."
      redirect_to @customer
    else
      flash.now.alert = @order.errors.full_messages.to_sentence
      render :new
    end
  end

  # PATCH/PUT /orders/1 or /orders/1.json
  def update
    @order = Order.find(params[:id])
    #@order.update(order_params)
    if @order.update(order_params)
      flash.notice = "The order was updated successfully."
      redirect_to order_path(@order)
    else
      flash.now.alert = @order.errors.full_messages.to_sentence
      render :edit
    end
  end

  # DELETE /orders/1 or /orders/1.json
  def destroy
    @order = Order.find(params[:id])
    @order.destroy
    redirect_to orders_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_customer
      @customer = Customer.find(order_params[:customer_id])
    end

    # Only allow a list of trusted parameters through.
    def order_params
      params.require(:order).permit(:product_name, :product_count, :customer_id)
    end


    def catch_not_found(e)
      Rails.logger.debug("We had a not found exception.")
      flash.alert = e.to_s
      redirect_to orders_path
    end

end
