Bikestand::Application.routes.draw do

  namespace :api do
  
    resources :contracts, only: [:index, :show], defaults: { format: 'json' } do
      member do
        get :stations
      end
    end
    
    resources :stations, only: [:index, :show], defaults: { format: 'json' }
  end
  
end
