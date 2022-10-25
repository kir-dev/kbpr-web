class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.references :user, null: false, foreign_key: true
      t.string :link
      t.integer :print_quantity
      t.string :paper_size
      t.text :comment
      t.boolean :sticker
      t.boolean :laminated
      t.boolean :printed_by_me

      t.timestamps
    end
  end
end
