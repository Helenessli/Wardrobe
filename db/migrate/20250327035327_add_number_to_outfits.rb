class AddNumberToOutfits < ActiveRecord::Migration[8.0]
  def change
    add_column :outfits, :number, :integer
  end
end
