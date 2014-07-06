class ContractsController < ApplicationController

  def index
  end

  def show
    @contract = Contract.find(params[:id])
  end
    
end
