class PurchasesController < ApplicationController
  before_action :authenticate_user!, except: :index
  def index
  end

  def new
    @purchase_form = PurchaseForm.new
  end

  def create
    @purchase_form = PurchaseForm.new(purchase_params)
    if @purchase_form.valid?
      @purchase_form.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def purchase_params
    params.require(:purchase_form).permit(:postal_code, :prefecture_id, :city, :address, :building_name,
                                          :phone_number).merge(user_id: current_user.id, item_id: params[:item_id])
  end
end
