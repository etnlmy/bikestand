require 'elevation'

class Station < ActiveRecord::Base
  include Elevation

  attr_accessible :address, :banking, :bonus, :elevation
  attr_accessible :latitude, :longitude, :name, :number
  
  belongs_to :contract
  
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :number, :address, presence: true
  validates :latitude, :longitude, presence: true
  validates :contract_id, presence: true
    
end
