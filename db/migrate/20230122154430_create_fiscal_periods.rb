class CreateFiscalPeriods < ActiveRecord::Migration[7.0]
  def change
    create_table :fiscal_periods do |t|
      t.datetime :start_at
      t.datetime :end_at

      t.timestamps
    end
  end
end
