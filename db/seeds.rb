# Fill the Contract and Station tables with the data from the JCDecaux
# platform

client = JCDecauxClient.new(API_KEYS["jcdecaux"]["key"])

client.contracts.each do |contract|

  new_contract = Contract.where(name: contract["name"].downcase).first_or_create!(
        name:            contract["name"],
        commercial_name: contract["commercial_name"],
        country_code:    contract["country_code"],
        cities:          contract["cities"] )
        
  stations = client.stations(contract_name: contract["name"])
  stations.each do |station|
    new_contract.stations.where(name: station["name"]).first_or_create(
        number:    station["number"],
        name:      station["name"],
        address:   station["address"],
        latitude:  station["position"]["lat"],
        longitude: station["position"]["lng"],
        elevation: 0,
        banking:   station["banking"],
        bonus:     station["bonus"])
  end
  
end