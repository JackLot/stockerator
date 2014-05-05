class AddOffsetToQuotesTable < ActiveRecord::Migration
  def change
  	add_column :quotes, :offset, :integer, :default => 0
  end
end
