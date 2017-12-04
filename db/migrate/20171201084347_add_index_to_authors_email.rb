class AddIndexToAuthorsEmail < ActiveRecord::Migration[5.1]
  def change
    add_index :authors, :email, unique: true
  end
end
