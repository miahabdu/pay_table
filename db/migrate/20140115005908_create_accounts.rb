class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.date :due_date
      t.integer :amount_due
      t.string :name
      t.string :site_link
      t.string :priority
      t.boolean :is_paid

      t.timestamps
    end
  end
end
