class AddTotalReturnToIndividuals < ActiveRecord::Migration
  def change
  	add_column :individuals, :total_return, :decimal
  end
end
