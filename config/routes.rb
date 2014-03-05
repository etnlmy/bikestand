Bikestand::Application.routes.draw do

  namespace :api do  
    resources :contracts, only: [:index, :show], defaults: { format: 'json' } do
      resources :stations, only: [:index, :show]
    end   
  end
  
end
