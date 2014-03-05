class CreateRecords < ActiveRecord::Migration
  def change
    create_table :records do |t|
      t.integer :station_id
      t.string :status
      t.integer :bike_stands
      t.integer :available_bike_stands
      t.integer :available_bikes
      t.timestamp :last_update

      t.timestamps
    end
    add_index :records, :station_id
  end
end
