class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]
  before_action :set_item, only: [:edit, :show, :update]
  before_action :correct_user, only: [:edit, :update]

  def index
    @items = Item.order(created_at: :desc)
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to items_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item.id)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def correct_user
    return if current_user.id == @item.user.id

    redirect_to root_path
  end

  def item_params
    params.require(:item).permit(:name, :image, :description, :category_id, :status_id, :shipping_fee_id, :prefecture_id,
                                 :delivery_time_id, :price).merge(user_id: current_user.id)
  end
end
