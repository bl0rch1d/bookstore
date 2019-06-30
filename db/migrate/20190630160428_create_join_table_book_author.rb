class CreateJoinTableBookAuthor < ActiveRecord::Migration[5.2]
  def change
    create_join_table :books, :authors do |t|
<<<<<<< HEAD
      t.index [:book_id, :author_id]
      t.index [:author_id, :book_id]
=======
      # t.index [:book_id, :author_id]
      # t.index [:author_id, :book_id]
>>>>>>> 61d09f106308376e7f2e9fd7c6cafd53f3c6148e
    end
  end
end
