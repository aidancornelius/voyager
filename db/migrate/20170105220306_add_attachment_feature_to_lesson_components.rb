class AddAttachmentFeatureToLessonComponents < ActiveRecord::Migration
  def self.up
    change_table :lesson_components do |t|
      t.attachment :feature
    end
  end

  def self.down
    remove_attachment :lesson_components, :feature
  end
end
