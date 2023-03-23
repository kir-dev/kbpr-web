class RemoveLinkFromOrderItems < ActiveRecord::Migration[7.0]
  def change
    remove_column :order_items, :link
  end
end
