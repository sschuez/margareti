class AddDetailsToUser < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :bio, :text
    add_column :users, :full_name, :string
  end
end
