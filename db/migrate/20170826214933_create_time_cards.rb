class CreateTimeCards < ActiveRecord::Migration[5.1]
  def change
    create_table :time_cards do |t|
      t.string :username
      t.date :occurence
      t.integer :total_hours_worked, :default => 0

      t.timestamps
    end
  end
end
