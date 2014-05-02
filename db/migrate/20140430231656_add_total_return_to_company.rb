class AddTotalReturnToCompany < ActiveRecord::Migration
  def change
  	add_column :companies, :total_return, :decimal
  end
end
