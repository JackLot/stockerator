class ChangePriceToToCents < ActiveRecord::Migration
  def change
  	rename_column :quotes, :price, :price_cents
  end
end
