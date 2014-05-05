class CreateIndividualPortfolioInvesetments < ActiveRecord::Migration
  def change
    create_table :individual_portfolio_invesetments do |t|
      t.integer :individual_id
      t.integer :portfolio_id
      t.money :amount
      t.date :buy_date
      t.date :sell_date
      t.decimal :percentage

      t.timestamps
    end
  end
end
