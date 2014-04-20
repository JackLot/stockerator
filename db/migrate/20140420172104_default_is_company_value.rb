class DefaultIsCompanyValue < ActiveRecord::Migration
  def change
  	change_column :investables, :isCompany, :boolean, :default => false
  end
end
