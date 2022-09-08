class CreatePostHeaders < ActiveRecord::Migration[6.1]
  def change
    create_table :post_headers do |t|

      t.integer :user_id, null: false
      t.string :comment, null: false

      t.timestamps
    end
  end
end
