require 'spec_helper'

describe "Contracts API" do

  before(:all) do
    @contract = FactoryGirl.create(:contract)
    9.times { FactoryGirl.create(:contract) }
    @station_1 = FactoryGirl.create(:station, contract: @contract)
    @station_2 = FactoryGirl.create(:station, contract: @contract)
  end
  after(:all) do 
    Contract.destroy_all
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
      get api_contract_stations_path(@contract)
      expect(response).to be_success
      json = JSON.parse(response.body)
      expect(json.length).to eq(2)
      expect(json[0]['name']).to eq(@station_1[:name])
      expect(json[1]['name']).to eq(@station_2[:name])
    end
  end
  
end