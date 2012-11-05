class ChangeColumnNameCompany < ActiveRecord::Migration
  def up
    remove_column :companies, :rae_material_used_by
  end

  def down
    add_column :companies, :raw_material_used_by, :text
  end
end
