class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :contracts

  def contracts
    @contracts = Contract.all
  end 

end
