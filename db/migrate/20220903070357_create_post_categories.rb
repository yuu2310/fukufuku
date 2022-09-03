class CreatePostCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :post_categories do |t|
      
      t.integer :post_id, null: false
      t.integer :category_id, null: false

      t.timestamps
    end
  end
end
