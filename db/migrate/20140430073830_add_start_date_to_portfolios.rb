class AddStartDateToPortfolios < ActiveRecord::Migration
  def change
  	add_column :portfolios, :start_date, :date
  end
end
