FactoryGirl.define do

  factory :contract do
    sequence(:name)             { |n| "Contract #{n}" }
    sequence(:commercial_name)  { |n| "Commercial Name #{n}" }
    country_code                "FR"
    cities                      ["Arcueil", "Aubervilliers", "Bagnolet"]
  end
  
  factory :station do
    sequence(:name)     { |n| "Station #{n}" }
    sequence(:number)   { |n| "#{n}" }
    sequence(:address)  { |n| "Address #{n}" }
    latitude            48.8645278209514
    longitude           2.416170724425901
    elevation           0.0
    banking             true
    bonus               true
    contract
  end
  
  factory :record do
    status                 "OPEN"
    bike_stands            12
    available_bike_stands  8
    available_bikes        4
    sequence(:last_update) { |n| Time.at(1393790284 + n) }         
    station
  end
  
end