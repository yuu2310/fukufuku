class AddNameToTypes < ActiveRecord::Migration[6.1]
  def change
    add_column :types, :name, :string
  end
end
