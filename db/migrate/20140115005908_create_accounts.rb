class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.date :due_date
      t.string :due_date_month
      t.string :due_date_year
      t.decimal :amount_due
      t.string :name
      t.string :url
      t.integer :priority
      t.boolean :is_paid
      t.boolean :is_reoccuring

      t.timestamps
    end
  end
end
