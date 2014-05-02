class AddFullNameToCompanies < ActiveRecord::Migration
  def change
  	add_column :companies, :full_name, :string
  end
end
