class CreateMediaStorages < ActiveRecord::Migration[5.0]
  def change
    create_table :media_storages do |t|
      t.string :title

      t.timestamps
    end
  end
end
