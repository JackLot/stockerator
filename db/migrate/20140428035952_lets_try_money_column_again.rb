class LetsTryMoneyColumnAgain < ActiveRecord::Migration
  def change
  	remove_column :quotes, :price_cents
  	add_money :quotes, :price
  end
end
