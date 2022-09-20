class Customers::ItemsController < ApplicationController
  def index
    @items = Item.page(params[:page]).per(8)
    @genres = Genre.all
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
    @genres = Genre.all
    @comment = Comment.new　#追加
    #@comments = @output.comments.includes(:user)
  end

  def search
    @items = Item.page(params[:page]).per(10).reverse_order
    @genre = Genre.find(params[:id])
    @genres = Genre.all
    @genre_items = @genre.items.page(params[:page]).per(8)
  end

  private
  
  def user_params
      params.require(:item).permit(:image)
  end
end
