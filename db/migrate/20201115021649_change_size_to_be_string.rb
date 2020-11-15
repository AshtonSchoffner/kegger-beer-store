class ChangeSizeToBeString < ActiveRecord::Migration[6.0]
  def change
    change_column :beers, :size, :string
  end
end
