class Customers::OrdersController < Customers::ApplicationController
  before_action :authenticate_customer!

  def new
    @order = Order.new
  end

  def confirm
    @order = Order.new(order_params)
    @cart_items = current_customer.cart_items
    @order.shipping_price = 800
    @total_price = (@cart_items.map { |cart_item| cart_item.item.add_tax_price * cart_item.amount }.sum ).floor

    #『ご自身の住所』を選択した場合
    if params[:order][:address_number] == "1"
      @order.post_code = current_customer.post_code
      @order.address = current_customer.address
      @order.name = current_customer.last_name + current_customer.first_name

    #『登録済住所から選択』を選択した場合
    elsif params[:order][:address_number] == "2"

			@address = Address.find(params[:order][:registered])
			@order.post_code = @address.post_code
			@order.address = @address.address
			@order.name = @address.name

		#『新しいお届け先』を選択した場合
		elsif params[:order][:address_number] == "3"
		  @address = Address.new
		  @address.customer_id = current_customer.id
		  @address.name = params[:order][:name]
		  @address.post_code = params[:order][:post_code]
		  @address.address = params[:order][:address]
      @order.post_code = @address.post_code
      @order.name = @address.name
      @order.address = @address.address
      @address.save
    else
      render :new
    end
  end

  def index
    @customer = current_customer
    @orders= @customer.orders.page(params[:page]).per(10)
  end

  def create
    order = Order.new(order_params)
    cart_items = current_customer.cart_items
    order.customer_id = current_customer.id
    order.shipping_price = 800
    order.price_all = order.shipping_price + order.total_payment
    order.save
    cart_items.each do |cart|
      order_detail = OrderDetail.new
      #cart変数からorder_detailに各カラムに代入
      order_detail.item_id  = cart.item_id
      order_detail.amount = cart.amount
      order_detail.price = (cart.item.price*1.10).floor
      order_detail.order_id = order.id
      order_detail.shipping_status = 0
      order_detail.save
    end
    #cartアイテムの削除
    current_customer.cart_items.destroy_all
    #カラムの代入
    redirect_to orders_complete_path
  end

  def show
    @order=Order.find(params[:id])
    @order_details = @order.order_details
  end

  def complete
  end

  private
  def order_params
    params.require(:order).permit(:post_code, :address, :name, :shipping_price, :total_payment, :payment_method, :status)
  end
end
