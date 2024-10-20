class ItemsController < ApplicationController
  def index
  end
  def new
    @item = Item.new
  end

  private

  def message_params
    permitted_attributes = [:name, :image, :description, :category_id, :status_id, :shipping_fee_id, :prefecture_id, :price]
    params.require(:item).permit(*permitted_attributes).merge(user_id: current_user.id)
  end
end
