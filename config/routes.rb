Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "users#index"

  get '/animal_shelters/search' => 'animal_shelters#search', as: :animal_shelters_search
  resources :users

  resources :animal_shelters
end
