class CreateCompletions < ActiveRecord::Migration[5.0]
  def change
    create_table :completions do |t|
      t.integer :user_id
      t.integer :lesson_component_id

      t.timestamps
    end
  end
end
