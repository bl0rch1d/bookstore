class CreateJoinTableMaterialBook < ActiveRecord::Migration[5.2]
  def change
    create_join_table :materials, :books do |t|
<<<<<<< HEAD
      t.index [:material_id, :book_id]
      t.index [:book_id, :material_id]
=======
      # t.index [:material_id, :book_id]
      # t.index [:book_id, :material_id]
>>>>>>> 61d09f106308376e7f2e9fd7c6cafd53f3c6148e
    end
  end
end
