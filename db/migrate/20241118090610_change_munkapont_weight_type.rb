class ChangeMunkapontWeightType < ActiveRecord::Migration[7.0]
  def change
    change_column :items, :munkapont_weight, :decimal, precision: 5, scale: 3
  end
end
