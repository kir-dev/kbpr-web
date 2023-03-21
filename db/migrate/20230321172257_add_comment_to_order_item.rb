class AddCommentToOrderItem < ActiveRecord::Migration[7.0]
  def change
    add_column :order_items, :comment, :string
  end
end
