class CreateQuotes < ActiveRecord::Migration
  def change
    create_table :quotes do |t|
      t.date :date
      t.decimal :price
      t.references :company
      
      t.timestamps
    end
  end
end
