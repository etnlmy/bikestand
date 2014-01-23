class Contract < ActiveRecord::Base

  VALID_COUNTRY_CODE_REGEX = /\A[a-z][a-z]\z/i
  
  attr_accessible :name, :commercial_name, :country_code, :cities
  
  has_many :stations
  
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :commercial_name, presence: true, uniqueness: { case_sensitive: false }
  validates :country_code, presence: true, format: {with: VALID_COUNTRY_CODE_REGEX}
  validates :cities, presence: true
  validate  :cities_cannot_be_empty
  serialize :cities
  
  before_save { |contract| contract.name = name.downcase }
  before_save { |contract| contract.commercial_name = commercial_name.downcase }
     
  def cities_cannot_be_empty
    cities.each do |city|
      errors.add(:cities, "cannot contain an empty city") if city.blank?
    end 
  end
  
end
