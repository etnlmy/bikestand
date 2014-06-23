class Api::StationsController < ApplicationController

  respond_to :json
  
  def index
    @contract = Contract.find(params[:contract_id])
    respond_with(@contract.stations)
  end
  
  def show
    @contract = Contract.find(params[:contract_id])
    respond_with(@contract.stations.find(params[:id]))
  end
  
end