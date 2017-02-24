class AddAttachmentAttachedDocumentToMediaStorages < ActiveRecord::Migration
  def self.up
    change_table :media_storages do |t|
      t.attachment :attached_document
    end
  end

  def self.down
    remove_attachment :media_storages, :attached_document
  end
end
