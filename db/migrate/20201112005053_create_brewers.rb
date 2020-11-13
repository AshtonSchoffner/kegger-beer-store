class CreateBrewers < ActiveRecord::Migration[6.0]
  def change
    create_table :brewers do |t|
      t.string :name
      t.references :country, null: false, foreign_key: true

      t.timestamps
    end
  end
end
