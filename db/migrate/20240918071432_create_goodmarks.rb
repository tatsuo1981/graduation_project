class CreateGoodmarks < ActiveRecord::Migration[7.2]
  def change
    create_table :goodmarks do |t|
      t.references :user, foreign_key: true
      t.references :board, foreign_key: true

      t.timestamps
    end
    add_index :goodmarks, [:user_id, :board_id], unique: true
  end
end
