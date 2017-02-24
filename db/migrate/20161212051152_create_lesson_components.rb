class CreateLessonComponents < ActiveRecord::Migration[5.0]
  def change
    create_table :lesson_components do |t|
      t.integer :lesson_id
      t.integer :style
      t.integer :order
      t.string :title
      t.text :body

      t.timestamps
    end
  end
end
