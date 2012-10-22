class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.string :description
      t.string :industry
      t.string :category
      t.boolean :raw_material
      t.boolean :finished_product

      t.timestamps
    end
  end
end
