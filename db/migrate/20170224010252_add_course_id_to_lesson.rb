class AddCourseIdToLesson < ActiveRecord::Migration[5.0]
  def change
    add_column :lessons, :course_id, :integer
  end
end
