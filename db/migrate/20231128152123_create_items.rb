class CreateItems < ActiveRecord::Migration[7.1]
  def change
    create_table :items do |t|
      t.belongs_to :block, null: false, foreign_key: true
      t.string :name
      t.text :content

      t.timestamps
    end
  end
end
