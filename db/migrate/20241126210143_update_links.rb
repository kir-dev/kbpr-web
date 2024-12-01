class UpdateLinks < ActiveRecord::Migration[7.0]
  def change
    add_column :links, :enabled, :boolean, default: true
  end
end
