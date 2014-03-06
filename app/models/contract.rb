class Contract < ActiveRecord::Base

  VALID_COUNTRY_CODE_REGEX = /\A[a-z][a-z]\z/i
  
  attr_accessible :name, :commercial_name, :country_code, :cities
  
  has_many :stations, dependent: :destroy
  
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :commercial_name, presence: true
  validates :country_code, presence: true, format: {with: VALID_COUNTRY_CODE_REGEX}
  validates :cities, presence: true
  validate  :cities_cannot_be_empty
  serialize :cities
  
  before_save { |contract| contract.name = name.downcase }
       
  def cities_cannot_be_empty
    cities.each do |city|
      errors.add(:cities, "cannot contain an empty city") if city.blank?
    end 
  end
  
  # Create a new Record on each of the stations
  #
  # jc_decaux_client - an instance of JCDecauxClient
  def update_stations(jc_decaux_client)
    data = jc_decaux_client.stations(contract_name: self.name) || []
    data.each do |station_data|
      self.stations.where(number: station_data["number"]).each do |station|
        station.create_new_record(station_data)
      end      
    end
  end
  
end
