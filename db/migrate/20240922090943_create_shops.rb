class CreateShops < ActiveRecord::Migration[7.2]
  def change
    create_table :shops do |t|
      t.string :shop_name, null: false
      t.string :address
      t.text :shop_hours
      t.string :tel
      t.integer :price, null: false
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
