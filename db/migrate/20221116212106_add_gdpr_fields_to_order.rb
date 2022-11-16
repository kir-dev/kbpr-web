class AddGdprFieldsToOrder < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :has_sch_logo, :boolean
    add_column :orders, :has_right_format, :boolean
  end
end
