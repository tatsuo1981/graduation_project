class ShopsController < ApplicationController
  def index
    @shops = Shop.includes(:user)
  end
end
