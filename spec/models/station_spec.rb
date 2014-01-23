require 'spec_helper'

describe Station do

  let(:contract) {FactoryGirl.create(:contract)}
  before { @station = contract.stations.build(
    number:   "31705",
    name:     "31705 - CHAMPEAUX (BAGNOLET)",
    address:  "RUE DES CHAMPEAUX (PRES DE LA GARE ROUTIERE) - 93170 BAGNOLET",
    latitude:  48.8645278209514,
    longitude: 2.416170724425901,
    banking:   true,
    bonus:     true,
    elevation: 0) }
    
  subject { @station }
  
  it { should respond_to(:number) }
  it { should respond_to(:name) }
  it { should respond_to(:address) }
  it { should respond_to(:latitude) }
  it { should respond_to(:longitude) }
  it { should respond_to(:banking) }
  it { should respond_to(:bonus) }
  it { should respond_to(:elevation) }
  its(:contract) { should == contract }
  
  it { should be_valid }
  
  describe "accessible attributes" do
    it "should not allow access to contract_id" do
      expect do
        Station.new(contract_id: "1")
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end
  
  describe "when contract_id is not present" do
    before { @station.contract_id = nil }
    it { should_not be_valid }
  end
  
  describe "when number is not present" do
    before { @station.number = nil }
    it { should_not be_valid }
  end
  
  describe "when name is not present" do
    before { @station.name = nil }
    it { should_not be_valid }
  end
  
  describe "when address is not present" do
    before { @station.address = nil }
    it { should_not be_valid }
  end
  
  describe "when latitude is not present" do
    before { @station.latitude = nil }
    it { should_not be_valid }
  end
  
  describe "when longitude is not present" do
    before { @station.longitude = nil }
    it { should_not be_valid }
  end
  
  describe "when banking is not present" do
    before { @station.banking = nil }
    it { should_not be_valid }
  end
  
  describe "when bonus is not present" do
    before { @station.bonus = nil }
    it { should_not be_valid }
  end
  
  describe "when elevation is not present" do
    before { @station.elevation = nil }
    it { should_not be_valid }
  end
  
  describe "when name is already taken" do
    before do
      station_with_same_name = @station.dup
      station_with_same_name.name = @station.name.upcase
      station_with_same_name.save
    end
  
    it { should_not be_valid }
  end
  
  describe "when number is already taken" do
    before do
      station_with_same_number = @station.dup
      station_with_same_number.number = @station.number
      station_with_same_number.save
    end
  
    it { should_not be_valid }
  end
  
end
