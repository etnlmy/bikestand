require 'spec_helper'

describe 'Records API' do

  before(:all) do
    @contract = FactoryGirl.create(:contract)
    @station = FactoryGirl.create(:station, contract: @contract)
    @records = []
    10.times { @records << FactoryGirl.create(:record, station: @station) }
  end
  after(:all) do 
    Contract.destroy_all
  end
  
  describe "search" do
    it "should return the correct records" do
      get api_records_path(@contract, @station)
      expect(response).to be_success
      json = JSON.parse(response.body)
      expect(json.length).to eq(10)
    end
  end
  
end