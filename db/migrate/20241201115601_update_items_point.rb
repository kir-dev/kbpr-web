class UpdateItemsPoint < ActiveRecord::Migration[7.0]
  def change
    rename_column :items, :munkapont_weight, :point
  end
end
