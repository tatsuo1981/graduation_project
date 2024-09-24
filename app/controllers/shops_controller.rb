class ShopsController < ApplicationController
  def index
    @q = Shop.ransack(params[:q])
    @shops = @q.result(distinct: true).includes(:user).order(created_at: :desc).page(params[:page])
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

  def show
    @shop = Shop.find(params[:id])
  end

  def edit
    @shop = current_user.shops.find(params[:id])
  end

  def update
    @shop = current_user.shops.find(params[:id])
    if @shop.update(shop_params)
      redirect_to shop_path(@shop), success: t('defaults.flash_message.updated', item: Shop.model_name.human)
    else
      flash.now[:danger] = t('defaults.flash_message.not_updated', item: Shop.model_name.human)
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    shop = current_user.shops.find(params[:id])
    shop.destroy!
    redirect_to shops_path, success: t('defaults.flash_message.deleted', item: Shop.model_name.human), status: :see_other
  end

  def bookmarks
    @q = current_user.bookmark_shops.ransack(params[:q])
    @bookmark_shops = @q.result(distinct: true).includes(:user).order(created_at: :desc).page(params[:page])
  end

  private

  def shop_params
    params.require(:shop).permit(:shop_name, :address, :tel, :shop_hours, :price, :shop_image, :shop_image_cache)
  end
end
