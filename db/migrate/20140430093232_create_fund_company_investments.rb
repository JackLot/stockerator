class CreateFundCompanyInvestments < ActiveRecord::Migration
  def change
    create_table :fund_company_investments do |t|
      t.integer :portfolio_id
      t.integer :company_id
      t.money :amount
      t.date :buy_date
      t.date :sell_date, :null => true

      t.timestamps
    end
  end
end
