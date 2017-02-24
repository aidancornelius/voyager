class CreateVoyagerCourses < ActiveRecord::Migration[5.0]
  def change
    create_table :courses do |t|
      t.string :title
      t.string :slug

      t.timestamps
    end
  end
end
