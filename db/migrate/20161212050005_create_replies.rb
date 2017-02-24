class CreateReplies < ActiveRecord::Migration[5.0]
  def change
    create_table :replies do |t|
      t.integer :lesson_component_id
      t.integer :user_id
      t.integer :reply_id
      t.text :body

      t.timestamps
    end
  end
end
