class AddNameToFiscalPeriods < ActiveRecord::Migration[7.0]
  def change
    add_column :fiscal_periods, :name, :string
  end
end
