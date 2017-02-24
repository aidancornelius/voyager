class CreateLessons < ActiveRecord::Migration[5.0]
  def change
    create_table :lessons do |t|
      t.string :title
      t.string :slug
      t.string :author
      t.text :description
      t.boolean :visible
      t.float :unlock

      t.timestamps
    end
  end
end
