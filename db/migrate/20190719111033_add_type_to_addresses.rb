class AddTypeToAddresses < ActiveRecord::Migration[5.2]
  def change
    add_column :addresses, :type, :integer
  end
end
