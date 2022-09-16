class Customers::HomesController < ApplicationController
  def top
    #Item=モデル名
    @genres = Genre.all
    @items = Item.page(params[:page]).per(4)
  end

end
