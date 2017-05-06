require 'json'

class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.all
    @users=User.all
     if current_user.admin == '1' 
         render "checks"  # checks
     else
       @orders =Order.order("id DESC").all
        render "index"
     end
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  # GET /orders/new
  def new
      @products = Product.all
      @categories = Category.all
      @users = User.all      
      puts ("products")
      puts @categories.first.products.size
      current_user.orders.last
      @order = Order.new
      # if current_user.admin == 0 
      #   show user dropdown list
      

  end

  # GET /orders/1/edit
  def edit
    @orders=Order.all
  end

  # POST /orders
  # POST /orders.json
  skip_before_action :verify_authenticity_token

  def create
      puts "hi :: "
      # ar = JSON.parse(params[:order])
      @order = Order.new()
      user = current_user
      if user.admin == 1
          @order.user =User.find(params[:order]['user_id'])
        else
          @order.user = user
      end 
      @order.notes = params[:order]['notes']
      @order.status = 0
      params[:order]['orderdetails'].each do |k,v|
        puts k
        @orderdetails = @order.orderdetails.build(:product => Product.find(v['product_id']) ,:quantity => v['quantity'])
        @orderdetails.save
      end

      #  params[:order].each do |o|
      #         if o.kind_of?(Array)
      #             o.each do |p|
      #               puts p
      #               puts "go"
      #             end
      #         else
      #           puts o
      #           puts "else"
      #         end
      #    end


    #  data = JSON.parse(order_params)

    #    puts  data
      # if current_user.admin == 0 
      #   get user from request
      #  else 
      #   get user from session
      
    respond_to do |format|
      if @order.save
        if request.xhr?
          format.json  { render :json => :ok, :status => :ok }
        else
          format.html { redirect_to @order, notice: 'Order was successfully created.' }
          format.json { render json: p, status: :created, location: @order }
        end
      else
        puts "errrrro"
        format.html { render :new }
        format.json { render json: order_params, status: :created }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if current_user.admin=='1'
                 if @order.update(params.require(:order).permit(:status))

                  format.html { redirect_to edit_order_path(@order), notice: 'Order was successfully updated.' }
                  format.json { render :show, status: :ok, location: @order }
                else
                  format.html { render :edit }
                  format.json { render json: @order.errors, status: :unprocessable_entity }
                end

      else
                if @order
                  @order.status=3
                  @order.save()
                  format.html { redirect_to orders_url, notice: 'Order was successfully updated.' }
                  format.json { render :show, status: :ok, location: @order }
                else
                  format.html { render :edit }
                  format.json { render json: @order.errors, status: :unprocessable_entity }
                  end
      end
     end
   end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find_by_id(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      # params.fetch(:order, {})
       params.permit(:order, :user_id , :notes, :orderdetails => [ :product_id, :quantity] )
      
    end
end
