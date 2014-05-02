class AddAnnualizedRateOfReturnToCompanies < ActiveRecord::Migration
  def change
  	add_column :companies, :annualized_ror, :decimal
  end
end
