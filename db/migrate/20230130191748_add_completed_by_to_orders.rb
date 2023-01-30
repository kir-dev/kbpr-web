class AddCompletedByToOrders < ActiveRecord::Migration[7.0]
  def change
    add_reference(:orders, :completed_by, foreign_key: { to_table: :users })
  end
end
