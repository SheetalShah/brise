class CreateAvatarsForRailsUser < ActiveRecord::Migration
  def self.up    
  #Tables
    create_table "avatars", :force => true do |t|
      t.integer  "user_id" 
      t.string   "logo_file_name"
      t.string   "logo_content_type"
      t.integer  "logo_file_size"
      t.datetime "logo_updated_at"
      t.boolean  "active", :default => true
    end
    
    add_index "avatars", "user_id"
    
  end
  
  def self.down
    drop_table :avatars
  end
end
