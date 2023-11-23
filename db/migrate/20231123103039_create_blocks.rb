class CreateBlocks < ActiveRecord::Migration[7.1]
  def change
    create_table :blocks do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.string :name
      t.integer :position

      t.timestamps
    end
  end
end
