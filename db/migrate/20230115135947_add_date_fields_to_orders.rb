class AddDateFieldsToOrders < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :finalized_at, :datetime
    add_column :orders, :completed_at, :datetime
  end
end
