class Customers::CommentsController < Customers::ApplicationController
  before_action :authenticate_customer!

  def create
    #商品のデーターを取得する
    @item = Item.find(params[:item_id])
    @comment = current_customer.comments.new(comment_params)
    @comment.item_id = @item.id
    pp @comment
    if @comment.save
      flash.now[:notice] = 'コメントを投稿しました'
      redirect_to item_path(@item)
    else
      render :show
    end
  end

  def destroy
    Comment.find_by(params[:id]).destroy
    redirect_to item_path(params[:item_id]), alert: 'コメントを削除しました'
  end

  private

  def comment_params
    #どのitemにcommentしたかをmergeしてあげる
    params.require(:comment).permit(:comment, :star).merge(item_id: params[:item_id])
  end

end