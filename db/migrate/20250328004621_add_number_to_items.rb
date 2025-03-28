class AddNumberToItems < ActiveRecord::Migration[8.0]
  def change
    add_column :items, :number, :integer
  end
end
