class AddTopsToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :tops, :string
  end
end
