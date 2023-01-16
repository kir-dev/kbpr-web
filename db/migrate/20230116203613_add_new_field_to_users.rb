class AddNewFieldToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :room_number, :integer
    add_column :users, :kwc, :boolean
  end
end
