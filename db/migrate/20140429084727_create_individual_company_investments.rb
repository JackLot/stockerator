class CreateIndividualCompanyInvestments < ActiveRecord::Migration
  def change
    create_table :individual_company_investments do |t|
      t.integer :individual_id
      t.integer :company_id
      t.money :amount
      t.date :buy_date
      t.date :sell_date, :null => true

      t.timestamps
    end
  end
end
