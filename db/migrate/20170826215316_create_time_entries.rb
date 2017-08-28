class CreateTimeEntries < ActiveRecord::Migration[5.1]
  def change
    create_table :time_entries do |t|
      t.datetime :time
      t.references :time_card , foreign_key: true

      t.timestamps
    end
  end
end
