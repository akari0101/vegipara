class Customers::ItemsController < ApplicationController
  def index
    @genres = Genre.all
    #タグで絞り込み機能
    if params[:search].present?
      items = Item.items_serach(params[:search])
    elsif params[:tag_id].present?
      @tag = Tag.find(params[:tag_id])
      items = @tag.items.order(created_at: :desc)
    else
      items = Item.all
    end
    @tag_lists = Tag.all
    @items = items.page(params[:page]).per(8)
    #投稿日を昇順で取り出し
    if params[:latest]
      @items = @items.latest
    elsif params[:old]
      @items = @items.old
    elsif params[:star_count]
      @items = @items.star_count
    end

    pp "hoge",@items
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    @item.customer_id = current_customer.id
    if @item.save
      tag_list = params[:item][:tag_name].sub(/　/," ").split(nil)
      @item.save_items(tag_list)
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
