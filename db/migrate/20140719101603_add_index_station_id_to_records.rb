class AddIndexStationIdToRecords < ActiveRecord::Migration
  def change
    add_index :records, :station_id
  end
end
