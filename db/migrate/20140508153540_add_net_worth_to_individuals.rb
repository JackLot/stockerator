class AddNetWorthToIndividuals < ActiveRecord::Migration
  def change
  	 add_column :individuals, :net_worth_cents, :integer
  	add_column :individuals, :net_worth_currency, :string
  end
end
