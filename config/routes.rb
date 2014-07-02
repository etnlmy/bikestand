Bikestand::Application.routes.draw do

  namespace :api do
   
    resources :contracts, only: [:index, :show], defaults: { format: 'json' } do
      resources :stations, only: [:index, :show]
    end 
    
    match "contracts/:id/stations/:id/records" => "records#search", :as => :records, format: 'json'
      
  end

  root :to => "contracts#index"
    
end
