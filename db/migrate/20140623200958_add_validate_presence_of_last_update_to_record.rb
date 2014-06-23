class AddValidatePresenceOfLastUpdateToRecord < ActiveRecord::Migration
  def change
    change_column :records, :last_update, :datetime, :null => false
  end
end
