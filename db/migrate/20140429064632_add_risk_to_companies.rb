class AddRiskToCompanies < ActiveRecord::Migration
  def change
  	add_column :companies, :risk, :decimal
  end
end
