class Record < ActiveRecord::Base

  attr_accessible :available_bike_stands, :available_bikes, :bike_stands
  attr_accessible :last_update, :status
  validates :status, inclusion: { in: %w(OPEN CLOSE) }
  
  belongs_to :station
end
