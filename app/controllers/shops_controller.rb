class ShopsController < ApplicationController
  def index
    @shops = Shop.includes(:user)
  end

  def new
    @shop = Shop.new
  end

  def create
    @shop = current_user.shops.build(shop_params)
    if @shop.save
      redirect_to shops_path, success: t('defaults.flash_message.created', item: Shop.model_name.human)
    else
      flash.now[:danger] = t('defaults.flash_message.not_created', item: Shop.model_name.human)
      render :new, status: :unprocessable_entity
    end
  end

  private

  def shop_params
    params.require(:shop).permit(:shop_name, :address, :tel, :shop_hours, :price,)
  end
end
