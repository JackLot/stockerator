class ChangeTypeToSomethingElse < ActiveRecord::Migration
  def change
  	rename_column :investables, :type, :e_type
  end
end
