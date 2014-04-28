class ChangePriceToNumCents < ActiveRecord::Migration
  def change
  	change_column :quotes, :price, :integer
  end
end
