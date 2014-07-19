class AddLastRecordToStation < ActiveRecord::Migration
  def change
    add_column :stations, :last_record, :string
  end
end
