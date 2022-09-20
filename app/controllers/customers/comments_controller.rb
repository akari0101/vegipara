class Customers::CommentsController < ApplicationController
  before_action :authenticate_customer!
  
  def create
    #商品のデーターを取得する
    @item = Item.find(params[:item_id])
    @comment = current_customer.comments.new(comment_params)
    @comment.item_id = @item.id
    if @comment.save
      flash.now[:notice] = 'コメントを投稿しました'
      render :create 
    else 
      render :error
    end
  end

  def destroy
    Comment.find_by(params[:id]).destroy
    redirect_to item_path(params[:item_id]), alert: 'コメントを削除しました'
  end
  
  private
  
  def comments_params
    #どのitemにcommentしたかをmergeしてあげる
    params.require(:comments).permit(:comment).merge(item_id: params[:item_id])
  end
  
end
params[:comments][:comment] 
params[:item_id]


params[:comments][:comment] 
params[:comments][:item_id]


