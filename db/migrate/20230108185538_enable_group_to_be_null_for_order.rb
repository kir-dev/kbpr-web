class EnableGroupToBeNullForOrder < ActiveRecord::Migration[7.0]
  def change
    change_column_null(:orders, :group_id, true)
  end
end
