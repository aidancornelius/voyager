class AddAttachmentDownloadToLandings < ActiveRecord::Migration
  def self.up
    change_table :landings do |t|
      t.attachment :download
    end
  end

  def self.down
    remove_attachment :landings, :download
  end
end
