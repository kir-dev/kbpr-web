class RemoveColumnsFromOrder < ActiveRecord::Migration[7.0]
  def change
    remove_column :orders, :laminated, :boolean
    remove_column :orders, :link, :string
    remove_column :orders, :sticker, :boolean
    remove_column :orders, :print_quantity, :integer
    remove_column :orders, :paper_size, :string
  end
end
