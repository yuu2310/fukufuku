class AddReferencesToCategory < ActiveRecord::Migration[6.1]
  def change
    add_reference :categories, :type, null: true, foreign_key: true
  end
end
