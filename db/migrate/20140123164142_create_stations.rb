class CreateStations < ActiveRecord::Migration
  def change
    create_table :stations do |t|
      t.integer :number
      t.string :name
      t.string :address
      t.float :latitude
      t.float :longitude
      t.float :elevation
      t.boolean :banking
      t.boolean :bonus
      t.integer :contract_id

      t.timestamps
    end
    add_index :stations, :name, unique: true
    add_index :stations, :contract_id
  end
end
