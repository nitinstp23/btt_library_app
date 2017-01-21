class CreateBooks < ActiveRecord::Migration[5.0]
  def change
    create_table :books do |t|
      t.string :title, null: false
      t.string :author, null: false
      t.string :isbn, null: false
      t.integer :quantity, default: 0, null: false

      t.timestamps
    end

    add_index :books, :isbn, unique: true
  end
end
