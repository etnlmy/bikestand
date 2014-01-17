class AddIndexToContractsCommercialName < ActiveRecord::Migration
  def change
    add_index :contracts, :commercial_name, unique: true
  end
end
