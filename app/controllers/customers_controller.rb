class CustomersController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :catch_not_found
  before_action :set_customer, only: %i[ show edit update destroy ]
  layout 'customer_layout'

  # GET /customers or /customers.json
  def index
    @customers = Customer.all
    render template: "customers/index.html.erb", layout: "application"
  end

  # GET /customers/1 or /customers/1.json
  def show
  end

  # GET /customers/new
  def new
    @customer = Customer.new
  end

  # GET /customers/1/edit
  def edit
  end

  # POST /customers or /customers.json
  def create
    @customer = Customer.new(customer_params)
    if @customer.save
      flash.notice = "The customer record was created successfully."
      redirect_to @customer
      #format.html { redirect_to @customer, notice: "The customer record was successfully created." }
      #format.json { render :show, status: :created, location: @customer }
    else
      #format.html { render :new, status: :unprocessable_entity }
      #format.json { render json: @customer.errors, status: :unprocessable_entity }
      flash.now.alert = @customer.errors.full_messages.to_sentence
      render :new  
    end
  end

  # PATCH/PUT /customers/1 or /customers/1.json
  def update
    if @customer.update(customer_params)
      #format.html { redirect_to @customer, notice: "The customer record was successfully updated." }
      #format.json { render :show, status: :ok, location: @customer }
      flash.notice = "The customer record was updated successfully."
      redirect_to @customer
    else
      flash.now.alert = @customer.errors.full_messages.to_sentence
      render :edit
    end
  end

  # DELETE /customers/1 or /customers/1.json
  def destroy
    @customer.destroy
    respond_to do |format|
      format.html { redirect_to customers_url, notice: "Customer was successfully deleted." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_customer
      @customer = Customer.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def customer_params
      params.require(:customer).permit(:first_name, :last_name, :phone, :email)
    end

    def catch_not_found(e)
      Rails.logger.debug("We had a not found exception.")
      flash.alert = e.to_s
      redirect_to customers_path
    end
end
