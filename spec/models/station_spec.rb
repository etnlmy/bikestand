require 'spec_helper'

describe Station do

  let(:contract) {FactoryGirl.create(:contract)}
  before { @station = FactoryGirl.build(:station, contract: contract)}
    
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
  
  describe "when name is already taken" do
    before do
      station_with_same_name = @station.dup
      station_with_same_name.name = @station.name.upcase
      station_with_same_name.save
    end
  
    it { should_not be_valid }
  end
  
  describe "fill elevation data" do
    before do
      @station.should_receive(:elevation_for).with(@station.latitude, @station.longitude)
        .and_return(123.4)
      @station.fill_elevation_data
      @station.reload
    end   
    
    its(:elevation) { should == 123.4  }
  end
  
  describe "record association" do
    before { @station.save }
    let!(:record_one) do
      FactoryGirl.create(:record, station: @station)
    end
    let!(:record_two) do
      FactoryGirl.create(:record, station: @station)
    end
    
    it "should have the right records" do
      @station.records.should == [record_one, record_two]
    end
    
    it "should destroy all the associated records" do
      records = @station.records.dup
      @station.destroy
      records.should_not be_empty
      records.each do |record|
        Record.find_by_id(record.id).should be_nil
      end
    end
    
    describe "call create_new_record" do  
      let (:data) { FactoryGirl.attributes_for(:record, station: @station).stringify_keys! }
      before do
        @station.records.destroy_all
        @station.records.count.should == 0
        @station.create_new_record(data)
        @station.reload  
      end
      
      it "should have one record with the right attributes" do
        @station.records.count.should == 1
        record = @station.records.first
        record.status.should == data["status"]
        record.bike_stands.should == data["bike_stands"]
        record.available_bike_stands.should == data["available_bike_stands"]
        record.available_bikes.should == data["available_bikes"]
        record.last_update.should == data["last_update"]
      end
    end
    
  end
  
end
