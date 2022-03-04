Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :message_users, only: [:index, :update] do
    member do
      get :access_to_message
      get :itinerary
    end
  end

  resources :messages, only: [:index, :show, :new, :destroy] do
    #member do
      #get :itinerary
    #end
  end
end
