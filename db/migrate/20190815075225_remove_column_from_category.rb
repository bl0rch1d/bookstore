class RemoveColumnFromCategory < ActiveRecord::Migration[5.2]
  def change
    remove_column :categories, :books_count
  end
end
