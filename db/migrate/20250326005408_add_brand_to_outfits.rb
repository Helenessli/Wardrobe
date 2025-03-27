class AddBrandToOutfits < ActiveRecord::Migration[8.0]
  def change
    add_column :outfits, :brand, :string
  end
end
