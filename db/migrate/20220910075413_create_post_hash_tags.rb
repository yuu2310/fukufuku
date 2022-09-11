class CreatePostHashTags < ActiveRecord::Migration[6.1]
  def change
    create_table :post_hash_tags do |t|

      t.integer :post_header_id, null: false
      t.integer :hash_tag_id, null: false

      t.timestamps
    end
  end
end
