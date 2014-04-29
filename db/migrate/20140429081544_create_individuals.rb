class CreateIndividuals < ActiveRecord::Migration
  def change
    create_table :individuals do |t|
      t.string :name
      t.money :cash
      t.integer :investable_id

      t.timestamps
    end
  end
end
