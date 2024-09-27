class Admin::ShopsController < Admin::BaseController
  before_action :set_shop, only: %i[edit update show destroy]

  def index
    @q = Shop.ransack(params[:q])
    @shops = @q.result(distinct: true).includes(:user).order(created_at: :desc).page(params[:page])
  end

  def edit; end

  def update
    if @shop.update(shop_params)
      redirect_to admin_shop_path(@shop), success: t('defaults.flash_message.updated', item: Shop.model_name.human)
    else
      flash.now['danger'] = t('defaults.flash_message.not_updated', item: Shop.model_name.human)
      render :edit
    end
  end

  def show; end

  def destroy
    @shop.destroy!
    redirect_to admin_shops_path, success: t('defaults.flash_message.deleted', item: Shop.model_name.human), status: :see_other
  end

  private

  def set_shop
    @shop = Shop.find(params[:id])
  end

  def shop_params
    params.require(:shop).permit(:shop_name, :address, :tel, :shop_hours, :price, :shop_image, :shop_image_cache)
  end
end