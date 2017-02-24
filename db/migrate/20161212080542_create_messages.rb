class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.integer :user_id
      t.integer :from_user_id
      t.integer :from_thread_id
      t.string :title
      t.text :body
      t.text :link
      t.boolean :read

      t.timestamps
    end
  end
end
