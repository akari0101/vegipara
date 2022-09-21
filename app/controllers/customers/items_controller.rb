class Customers::ItemsController < ApplicationController
  def index
    @items = Item.page(params[:page]).per(8)
    @genres = Genre.all
    #投稿日を昇順で取り出し
    if params[:latest]
      @items = Item.latest
    elsif params[:old]
      @items = Item.old
    elsif params[:star_count]
      @items = Item.star_count
    else
      @items = Item.all
    end
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    @item.customer_id = current_customer.id
    if @item.save
      redirect_to items_path
    else
      render action: :new
    end
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
    @genres = Genre.all
    @comment = Comment.new #追加
    #@comments = @output.comments.includes(:user)
  end

  def search
    @items = Item.page(params[:page]).per(10).reverse_order
    @genre = Genre.find(params[:id])
    @genres = Genre.all
    @genre_items = @genre.items.page(params[:page]).per(8)
  end

  private

  # def user_params
  #     params.require(:item).permit(:image, :star)
  # end
  def item_params
    params.require(:item).permit(:name,:introduction,:price,:image,:is_active,:genre_id)
  end
end
