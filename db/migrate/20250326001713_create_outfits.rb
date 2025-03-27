class CreateOutfits < ActiveRecord::Migration[8.0]
  def change
    create_table :outfits do |t|
      t.string :theme
      t.string :image

      t.timestamps
    end
  end
end
