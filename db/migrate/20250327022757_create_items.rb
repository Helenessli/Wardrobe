class CreateItems < ActiveRecord::Migration[8.0]
  def change
    create_table :items do |t|
      t.string :brand
      t.string :link
      t.string :name

      t.timestamps
    end
  end
end
