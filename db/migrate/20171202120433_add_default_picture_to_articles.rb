class AddDefaultPictureToArticles < ActiveRecord::Migration[5.1]
  def change
    add_column :articles, :default_picture, :string
  end
end
