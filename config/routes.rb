Rails.application.routes.draw do
  resources :stores, only: [:create]
  resources :products, only: [:create, :index, :show] do
    member do
      post :inventory, action: :update_inventory
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
