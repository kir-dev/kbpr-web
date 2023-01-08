class CreateOrderItems < ActiveRecord::Migration[7.0]
  def change
    create_table :order_items do |t|
      t.references :order, null: false, foreign_key: true
      t.references :item, null: false, foreign_key: true
      t.decimal :price, null: false
      t.integer :quantity, null: false
      t.boolean :laminated, null: false
      t.string :link, null: false

      t.timestamps
    end
  end
end
