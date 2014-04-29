class AddStrictlyIncreasingColumnToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :strict_increasing, :boolean, :default => false
  end
end
