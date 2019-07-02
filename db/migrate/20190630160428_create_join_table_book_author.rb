class CreateJoinTableBookAuthor < ActiveRecord::Migration[5.2]
  def change
    create_join_table :books, :authors do |t|
      t.index %i[book_id author_id]
      t.index %i[author_id book_id]
    end
  end
end
