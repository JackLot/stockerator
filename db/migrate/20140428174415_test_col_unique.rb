class TestColUnique < ActiveRecord::Migration
  def change
  	add_index :investables, :name, :unique => true
  end
end
