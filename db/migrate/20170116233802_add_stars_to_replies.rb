class AddStarsToReplies < ActiveRecord::Migration[5.0]
  def change
    add_column :replies, :stars, :integer
  end
end
