class Api::StationsController < ApplicationController

  respond_to :json
  
  def index
    respond_with(Station.all)
  end
  
  def show
    respond_with(Station.find(params[:id]))
  end
  
end