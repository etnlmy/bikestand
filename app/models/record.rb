class Record < ActiveRecord::Base

  attr_accessible :available_bike_stands, :available_bikes, :bike_stands
  attr_accessible :last_update, :status
  validates :status, inclusion: { in: %w(OPEN CLOSE) }
  validates :last_update, presence: true
  
  belongs_to :station
  
  scope :last_24_hours, lambda { where("last_update > ?", 1.day.ago.to_i ) }

end
