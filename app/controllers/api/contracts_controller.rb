class Api::ContractsController < ApplicationController

  respond_to :json
  
  def index
    respond_with(@contracts = Contract.all)
  end
  
  def show
    respond_with(@contract = Contract.find(params[:id]))
  end
end
