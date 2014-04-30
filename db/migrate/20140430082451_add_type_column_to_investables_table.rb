class AddTypeColumnToInvestablesTable < ActiveRecord::Migration
  def change
  	add_column :investables, :type, :integer, :default => 0
  end
end
