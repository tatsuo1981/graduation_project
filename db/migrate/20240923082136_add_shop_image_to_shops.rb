class AddShopImageToShops < ActiveRecord::Migration[7.2]
  def change
    add_column :shops, :shop_image, :string
  end
end
