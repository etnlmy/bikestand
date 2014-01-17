class CreateContracts < ActiveRecord::Migration
  def change
    create_table :contracts do |t|
      t.string :name
      t.string :commercial_name
      t.string :country_code
      t.string :cities

      t.timestamps
    end
  end
end
