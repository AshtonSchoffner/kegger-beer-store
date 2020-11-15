class CreateBeers < ActiveRecord::Migration[6.0]
  def change
    create_table :beers do |t|
      t.string :name
      t.float :price
      t.float :alcohol_vol
      t.integer :size
      t.integer :quantity
      t.text :description
      t.references :brewer, null: false, foreign_key: true
      t.references :subcategory, null: false, foreign_key: true

      t.timestamps
    end
  end
end
