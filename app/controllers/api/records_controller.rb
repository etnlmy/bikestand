class Api::RecordsController < ApplicationController

  respond_to :json
  
  def search
    respond_with(Record.all)
  end
  
end