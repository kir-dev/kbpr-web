class CreateFunkyTexts < ActiveRecord::Migration[7.0]
  def change
    create_table :funky_texts do |t|
      t.string :title

      t.timestamps
    end
  end
end
