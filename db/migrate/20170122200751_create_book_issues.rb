class CreateBookIssues < ActiveRecord::Migration[5.0]
  def change
    create_table :book_issues do |t|
      t.integer  :book_id
      t.integer  :consumer_id
      t.datetime :issued_at
      t.date     :due_date

      t.timestamps
    end

    add_index :book_issues, [:book_id, :consumer_id], unique: true
  end
end
