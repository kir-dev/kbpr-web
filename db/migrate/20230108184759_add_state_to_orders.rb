class AddStateToOrders < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :state, :string, default: :draft
  end
end
