class CreatePostDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :post_details do |t|

      t.integer :post_header_id, null: false
      t.integer :category_id, null: false
      t.string :size, null: false

      t.timestamps
    end
  end
end
