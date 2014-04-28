class CreatePortfolios < ActiveRecord::Migration
  def change
    create_table :portfolios do |t|
      t.string :name
      t.boolean :isIndividual
      t.integer :investable_id
      t.money :cash

      t.timestamps
    end
  end
end
