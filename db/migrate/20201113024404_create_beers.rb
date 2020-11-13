class CreateBeers < ActiveRecord::Migration[6.0]
  def change
    create_table :beers do |t|
      t.string :name
      t.string :size
      t.float :alcohol_vol
      t.float :price
      t.integer :quantity
      t.text :description
      t.references :category, null: false, foreign_key: true
      t.references :brewer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
