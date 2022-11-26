class AddHasDateToOrder < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :has_date, :boolean
  end
end
