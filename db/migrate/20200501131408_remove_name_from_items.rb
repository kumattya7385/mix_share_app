class RemoveNameFromItems < ActiveRecord::Migration[6.0]
  def change

    remove_column :items, :name, :string
  end
end
