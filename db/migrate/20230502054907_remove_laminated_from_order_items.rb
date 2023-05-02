class RemoveLaminatedFromOrderItems < ActiveRecord::Migration[7.0]
  def change
    remove_column :order_items, :laminated
  end
end
