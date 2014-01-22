require 'spec_helper'

describe "Contracts API" do

  before(:all) do
    @contract = FactoryGirl.create(:contract)
    9.times { FactoryGirl.create(:contract) }
  end 
  after(:all) { Contract.delete_all }
  
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
      expect(json["cities"]).to eq(@contract.cities) 
    end
  end
  
end