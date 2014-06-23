require 'spec_helper'

describe Record do

  let(:contract) { FactoryGirl.create(:contract) }
  let(:station) { FactoryGirl.create(:station, contract: contract) }
  
  before { @record = FactoryGirl.create(:record, station: station) }
  
  subject { @record }
  
  it { should respond_to(:status) }
  it { should respond_to(:bike_stands) }
  it { should respond_to(:available_bike_stands) }
  it { should respond_to(:available_bikes) }
  it { should respond_to(:last_update) }
  
  its(:station) { should == station }
  
  it { should be_valid }
  
  describe "accessible attributes" do   
    it "should not allow access to station_id"  do
      expect do
        Record.new(station_id: "1")
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end 

  describe "when last_update is nil" do
    before { @record.last_update = nil }
    it { should_not be_valid }
  end
  
  describe "when status is not OPEN or CLOSE" do
    before { @record.status = "OTHER" }
    it { should_not be_valid }
  end
  
end
