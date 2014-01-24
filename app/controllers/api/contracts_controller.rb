class Api::ContractsController < ApplicationController

  respond_to :json
  
  def index
    respond_with(Contract.all)
  end
  
  def show
    respond_with(Contract.find(params[:id]))
  end
  
  def stations
    @contract = Contract.find(params[:id])
    respond_with(@contract.stations)
  end
end
