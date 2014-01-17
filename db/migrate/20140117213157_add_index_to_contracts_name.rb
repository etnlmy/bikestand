class AddIndexToContractsName < ActiveRecord::Migration
  def change
    add_index :contracts, :name, unique: true
  end
end
