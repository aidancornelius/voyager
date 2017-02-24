class CreatePageSections < ActiveRecord::Migration[5.0]
  def change
    create_table :page_sections do |t|
      t.integer :page_id
      t.integer :order
      t.string :title
      t.text :body

      t.timestamps
    end
  end
end
