class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.string :nombre, null: false
      t.float :precio, null: false
      t.integer :cantidad, null: false
      t.integer :stock, null: false
      t.string :description
      t.timestamps
    end
  end
end
