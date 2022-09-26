class Customers::CartItemsController < Customers::ApplicationController
  before_action :authenticate_customer!

  def index
    @cart_items = current_customer.cart_items
    @total = @cart_items.inject(0) { |sum, item| sum + item.sum_of_price }
  end

  def create
    #binding.pry
    if @cart_item = CartItem.find_by(customer_id: current_customer.id, item_id: cart_item_params[:item_id])
      @cart_item.amount += cart_item_params[:quantity].to_i
      @cart_item.save!
      redirect_to cart_items_path
    elsif @cart_item = current_customer.cart_items.new(cart_item_params)
      @cart_item.customer_id = current_customer.id
      @cart_item.save!
      redirect_to cart_items_path
    else
      render 'index'
    end
  end

  def update
    puts params
    @cart_item = CartItem.find(params[:id])
    @cart_item.update(cart_item_params)
    redirect_to cart_items_path
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to cart_items_path
  end

  def destroy_all
    @cart_items = current_customer.cart_items
    @cart_items.destroy_all
    redirect_to cart_items_path
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:customer_id, :item_id, :amount)
  end

end
