class CreateInvestables < ActiveRecord::Migration
  def change
    create_table :investables do |t|
      t.string :name
      t.boolean :isCompany

      t.timestamps
    end
  end
end
