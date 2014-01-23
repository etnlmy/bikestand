require 'spec_helper'

describe Contract do
  before { @contract = Contract.new(
      name: "Paris",
      commercial_name: "Velib",
      country_code: "FR",
      cities: ["Arcueil", "Aubervilliers", "Bagnolet"]) }
      
  subject {@contract}
  
  it { should respond_to(:name) }
  it { should respond_to(:commercial_name) }  
  it { should respond_to(:country_code) }
  it { should respond_to(:cities) }    
  
  it { should be_valid }
  
  describe "when name is not present" do
    before { @contract.name = " " }
    it {should_not be_valid}
  end
  
  describe "when commercial_name is not present" do
    before { @contract.commercial_name = " " }
    it {should_not be_valid}
  end
  
  describe "when country_code is not present" do
    before { @contract.country_code = " " }
    it {should_not be_valid}
  end
  
  describe "when cities is empty" do
    before { @contract.cities = [] }
    it {should_not be_valid}
  end
  
  describe "when one city is empty" do
    before { @contract.cities = [" "] }
    it {should_not be_valid}
  end
  
  describe "when country_code format is invalid" do
    it "should be invalid" do
      country_codes = %w[d dTh kfya]
      country_codes.each do |invalid_country_code|
        @contract.country_code = invalid_country_code
        @contract.should_not be_valid
      end
    end
  end
  
  describe "when country_code format is valid" do
    it "should be valid" do
      country_codes = %w[fr De UK]
      country_codes.each do |valid_country_code|
        @contract.country_code = valid_country_code
        @contract.should be_valid
      end
    end
  end
  
  describe "when name is already taken" do
    before do
      contract_with_same_name = @contract.dup
      contract_with_same_name.name = @contract.name.upcase
      contract_with_same_name.save
    end

    it { should_not be_valid }
  end 
  
  describe "when commercial_name is already taken" do
    before do
      contract_with_same_commercial_name = @contract.dup
      contract_with_same_commercial_name.commercial_name = @contract.commercial_name.upcase
      contract_with_same_commercial_name.save
    end

    it { should_not be_valid }
  end   
  
  describe "station association" do
    before {@contract.save}
    let!(:station_one) do
      FactoryGirl.create(:station, contract: @contract)
    end
    let!(:station_two) do
      FactoryGirl.create(:station, contract: @contract)
    end
    
    it "should have the right station" do
      @contract.stations.should == [station_one, station_two]
    end
    
    it "should destroy the associated stations" do
      stations = @contract.stations.dup
      @contract.destroy
      stations.should_not be_empty
      stations.each do |station|
        Station.find_by_id(station.id).should be_nil
      end
    end
    
  end
  
end
