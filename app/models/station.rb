require 'elevation'

class Station < ActiveRecord::Base
  include Elevation

  attr_accessible :address, :banking, :bonus, :elevation
  attr_accessible :latitude, :longitude, :name, :number, :last_record
  
  belongs_to :contract
  has_many :records, dependent: :destroy
  
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :number, presence: true
  validates :latitude, :longitude, presence: true
  validates :contract_id, presence: true

  serialize :last_record
  
  # Create a new Record from the JCDecaux real time data
  #
  # data - a hash containing fresh data of a station obtained from
  # the JCDecauxClient
  def create_new_record(data)
    new_record = {
      status: data["status"],
      bike_stands: data["bike_stands"],
      available_bike_stands: data["available_bike_stands"],
      available_bikes: data["available_bikes"],
      last_update: Time.at(data["last_update"]/1000)
    }
    self.records.create(new_record)
    update_attribute(:last_record, new_record)
  end
  
  def fill_elevation_data
    update_attribute(:elevation, elevation_for(self.latitude, self.longitude))
  end
    
end
