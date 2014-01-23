class Station < ActiveRecord::Base
  attr_accessible :address, :banking, :bonus, :elevation
  attr_accessible :latitude, :longitude, :name, :number
  
  belongs_to :contract
  
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :number, presence: true, uniqueness: true
  validates :address, :banking, :bonus, :elevation, presence: true
  validates :latitude, :longitude, presence: true
  validates :contract_id, presence: true
end
