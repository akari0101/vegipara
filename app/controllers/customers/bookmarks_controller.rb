class Customers::BookmarksController < Customers::ApplicationController
  before_action :authenticate_customer!

  def show
    @bookmarks = Bookmark.where(customer_id: current_customer.id)
  end

  def create
    #item_idを取得し、その後customer_idにcurrent_customerを紐付け
    @item = Item.find(params[:item_id])
    bookmark = @item.bookmarks.new(customer_id: current_customer.id)
    if bookmark.save
      redirect_to request.referer
    else
      redirect_to request.referer
    end
  end

  def destroy
    @item = Item.find(params[:item_id])
    bookmark = @item.bookmarks.find_by(customer_id: current_customer.id)
    #bookmark.present?は、２度押しのエラーを回避するため
    if bookmark.present?
        bookmark.destroy
        redirect_to request.referer
    else
        redirect_to request.referer
    end
  end
end
