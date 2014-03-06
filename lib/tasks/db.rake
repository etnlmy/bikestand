namespace :db do
  
  desc "Look for stations where elevation is nil and fill it in"
  task :elevation => :environment do
    puts "filling in elevation data ..."
    Station.where(elevation: nil).limit(10).each do |station|
      station.fill_elevation_data
    end
    puts "Done."
  end
  
  desc "Update every station's status"
  task :new_record => :environment do  
    client = JCDecauxClient.new(API_KEYS["jcdecaux"]["key"])   
    Contract.find_each do |contract|
      puts "updating stations for contract '#{contract.name}'"
      contract.update_stations(client)
    end
    puts "Done."
  end
  
end