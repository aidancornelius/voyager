class AddAttachmentFileToMediaStorages < ActiveRecord::Migration
  def self.up
    change_table :media_storages do |t|
      t.attachment :file
    end
  end

  def self.down
    remove_attachment :media_storages, :file
  end
end
