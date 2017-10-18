Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "users#index"

  get '/animal_shelters/search' => 'animal_shelters#search', as: :animal_shelters_search

  patch '/users/id' => 'animal_shelters#add_id', as: :add_id
  resources :users
  resources :sessions, only: [:create]
  resources :animal_shelters

  get "/sign_in" => "sessions#new", as: "sign_in"
  delete "/sign_out" => "sessions#destroy", as: "sign_out"

end
