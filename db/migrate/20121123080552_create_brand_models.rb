class CreateBrandModels < ActiveRecord::Migration
  def change
    create_table :brands_models do |t|
      t.integer :brand_id, :null => false
      t.integer :model_id, :null => false
    end
  end
end
