class CreatePostTagRelations < ActiveRecord::Migration[6.1]
  def change
    create_table :post_tag_relations do |t|
      t.integer :tag_id, null: false
      t.integer :post_id, null: false

      t.timestamps
    end
  end
end
