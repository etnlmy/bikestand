class Api::RecordsController < ApplicationController

  respond_to :json
  
  def search
    respond_with(Station.find(params[:id]).records)
  end
  
end