class AddStartDateColumnToIndividuals < ActiveRecord::Migration
  def change
  	add_column :individuals, :start_date, :date
  end
end
