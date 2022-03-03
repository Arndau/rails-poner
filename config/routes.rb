Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :message_users, only: [:index]
  resources :messages_users, only: [:index, :show, :new, :destroy] do
    resources :message_users, only: [:update]
    member do
      get :itinerary
    end
  end

end
