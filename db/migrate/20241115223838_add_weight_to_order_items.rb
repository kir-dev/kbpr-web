class AddWeightToOrderItems < ActiveRecord::Migration[7.0]
  def change
    add_column :items, :munkapont_weight, :int, default: 1
  end
end
