class AddColumnToHelp < ActiveRecord::Migration
  def change
	add_column :helps, :content, :string
  end
end
