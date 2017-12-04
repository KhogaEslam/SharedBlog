class CreateArticles < ActiveRecord::Migration[5.1]
  def change
    create_table :articles do |t|
      t.string :title
      t.text :content
      t.references :author, foreign_key: true

      t.timestamps
    end
    add_index :articles, [:author_id, :created_at]
  end
end
