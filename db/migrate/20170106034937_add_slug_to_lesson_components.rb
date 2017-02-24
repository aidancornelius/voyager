class AddSlugToLessonComponents < ActiveRecord::Migration[5.0]
  def change
    add_column :lesson_components, :slug, :string
  end
end
