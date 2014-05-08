class AddNetWorthToPortolios < ActiveRecord::Migration
  def change
  	add_column :portfolios, :net_worth_cents, :integer
  	add_column :portfolios, :net_worth_currency, :string
  end
end
