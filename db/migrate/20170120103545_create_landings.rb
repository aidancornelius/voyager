class CreateLandings < ActiveRecord::Migration[5.0]
  def change
    create_table :landings do |t|
      t.string :title
      t.string :slug_before
      t.string :slug_after
      t.text :body_before
      t.text :body_after
      t.string :mailchimp_list

      t.timestamps
    end
  end
end
