class AddAttachmentToAds < ActiveRecord::Migration
  def self.up
    change_table :ads do |t|
      t.attachment :avatar
    end
  end
  def self.down
    drop_attached_file :users, :avatar
  end
end
