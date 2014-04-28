class SetIsIndividualDefault < ActiveRecord::Migration
  def change
  	change_column :portfolios, :isIndividual, :boolean, :default => true
  end
end
