require 'spec_helper'

describe "Contracts API" do

  before(:all) do
    @contract = FactoryGirl.create(:contract)
    9.times { FactoryGirl.create(:contract) }
    @stations = @contract.stations.create(
      number:   "31705",
      name:     "31705 - CHAMPEAUX (BAGNOLET)",
      address:  "RUE DES CHAMPEAUX (PRES DE LA GARE ROUTIERE) - 93170 BAGNOLET",
      latitude:  48.8645278209514,
      longitude: 2.416170724425901,
      banking:   true,
      bonus:     true,
      elevation: 0)
  end
  after(:all) do 
    Contract.delete_all
    Station.delete_all
  end
  
  describe "index" do   
    it "should return all the contracts as JSON response" do
      get api_contracts_path
      expect(response).to be_success
      json = JSON.parse(response.body)
      expect(json.length).to eq(10)     
    end
  end
  
  describe "show" do
    it "should return the right contract as JSON response" do
      get api_contract_path(@contract)
      expect(response).to be_success
      json = JSON.parse(response.body)
      expect(json['cities']).to eq(@contract.cities) 
    end
  end
  
  describe "stations" do    
    it "should return the right station as JSON response" do
      get stations_api_contract_path(@contract)
      expect(response).to be_success
      json = JSON.parse(response.body)
      expect(json.length).to eq(1)
      expect(json[0]['name']).to eq("31705 - CHAMPEAUX (BAGNOLET)")
    end
  end
  
end