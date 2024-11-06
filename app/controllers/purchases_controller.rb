class PurchasesController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create]
  before_action :set_item, only: [:index, :create]
  def index
    gon.public_key = ENV['PAYJP_PUBLIC_KEY']
    @purchase_form = PurchaseForm.new
  end

  def new
    @purchase_form = PurchaseForm.new
  end

  def create
    @purchase_form = PurchaseForm.new(purchase_params)
    if @purchase_form.valid?
      pay_item
      @purchase_form.save
      @item.update(sale_status: 1)
      redirect_to root_path
    else
      gon.public_key = ENV['PAYJP_PUBLIC_KEY']
      render :index, status: :unprocessable_entity
    end
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
    redirect_to root_path if @item.sold_out? || @item.user_id == current_user.id
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,
      card: purchase_params[:token],
      currency: 'jpy'
    )
  end

  def purchase_params
    params.require(:purchase_form).permit(:postal_code, :prefecture_id, :city, :address, :building_name,
                                          :phone_number).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end
end
