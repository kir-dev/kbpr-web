class AddMemberColumnToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :member, :boolean, default: false
  end
end
