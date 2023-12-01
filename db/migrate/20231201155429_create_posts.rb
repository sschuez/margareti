class CreatePosts < ActiveRecord::Migration[7.1]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :subtitle
      t.text :body
      t.boolean :published
      t.integer :position
      t.belongs_to :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
