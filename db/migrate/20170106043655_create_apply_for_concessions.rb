class CreateApplyForConcessions < ActiveRecord::Migration[5.0]
  def change
    create_table :apply_for_concessions do |t|
      t.integer :user_id
      t.string :type
      t.boolean :acknowledgement

      t.timestamps
    end
  end
end
