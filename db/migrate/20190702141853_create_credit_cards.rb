class CreateCreditCards < ActiveRecord::Migration[5.2]
  def change
    create_table :credit_cards do |t|
      t.string :card_name
      t.string :number
      t.string :cvv
      t.string :expiration_date
      t.references :order, foreign_key: true

      t.timestamps
    end
  end
end
