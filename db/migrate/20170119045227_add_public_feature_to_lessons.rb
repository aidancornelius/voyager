class AddPublicFeatureToLessons < ActiveRecord::Migration[5.0]
  def change
    add_column :lessons, :public_feature, :string
  end
end
