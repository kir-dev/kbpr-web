class CreateLinks < ActiveRecord::Migration[7.0]
  def change
    create_table :links do |t|
      t.string :url
      t.string :slug
      t.integer :clicks, default: 0
      t.string :title
      t.timestamps
    end
  end
end
