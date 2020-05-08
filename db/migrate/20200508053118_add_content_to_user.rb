class AddContentToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :content, :string
  end
end
