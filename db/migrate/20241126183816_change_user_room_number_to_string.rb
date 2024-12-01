class ChangeUserRoomNumberToString < ActiveRecord::Migration[7.0]
  def change
    change_column :users, :room_number, :string
  end
end
