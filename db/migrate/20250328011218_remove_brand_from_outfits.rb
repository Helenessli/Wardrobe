class RemoveBrandFromOutfits < ActiveRecord::Migration[8.0]
  def change
    remove_column :outfits, :brand, :string
  end
end
