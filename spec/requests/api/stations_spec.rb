require 'spec_helper'

describe "Stations API" do
  
  before(:all) do
    @contract_1 = FactoryGirl.create(:contract)
    @contract_2 = FactoryGirl.create(:contract)
    @station = FactoryGirl.create(:station, contract: @contract_1)
    9.times { FactoryGirl.create(:station, contract: @contract_1) }
    5.times { FactoryGirl.create(:station, contract: @contract_2) }
  end
  after(:all) do 
    Contract.destroy_all
  end
  
  describe "index" do
    it "should return the stations of the queried contract as JSON response" do
      get api_contract_stations_path(@contract_1)
      expect(response).to be_success
      json = JSON.parse(response.body)
      expect(json.length).to eq(10) 
    end 
  end
  
  describe "show" do
    it "should return the right stations as JSON response" do
      get api_contract_station_path(@contract_1, @station)
      expect(response).to be_success
      json = JSON.parse(response.body)
      expect(json['name']).to eq(@station[:name])
    end
  end
  
end