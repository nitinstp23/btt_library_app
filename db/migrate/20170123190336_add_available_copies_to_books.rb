class AddAvailableCopiesToBooks < ActiveRecord::Migration[5.0]
  def change
    add_column :books, :available_copies, :integer, default: 0, null: false

    update 'UPDATE books SET available_copies = 0'
  end
end
