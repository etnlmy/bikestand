require 'spec_helper'

describe "Stations API" do
  
  before(:all) do
    @contract = FactoryGirl.create(:contract)
    @station = FactoryGirl.create(:station, contract: @contract)
    9.times { FactoryGirl.create(:station, contract: @contract) }
  end
  after(:all) do 
    Contract.delete_all
    Station.delete_all
  end
  
  describe "index" do
    it "should return all the stations as JSON response" do
      get api_stations_path
      expect(response).to be_success
      json = JSON.parse(response.body)
      expect(json.length).to eq(10) 
    end 
  end
  
  describe "show" do
    it "should return the right stations as JSON response" do
      get api_station_path(@station)
      expect(response).to be_success
      json = JSON.parse(response.body)
      expect(json['name']).to eq(@station[:name])
    end
  end
  
end