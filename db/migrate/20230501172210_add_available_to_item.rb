class AddAvailableToItem < ActiveRecord::Migration[7.0]
  def change
    add_column :items, :available, :boolean, default: true
  end
end
