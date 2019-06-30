class CreateJoinTableMaterialBook < ActiveRecord::Migration[5.2]
  def change
    create_join_table :materials, :books do |t|
      # t.index [:material_id, :book_id]
      # t.index [:book_id, :material_id]
    end
  end
end
