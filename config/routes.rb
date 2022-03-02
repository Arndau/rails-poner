Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :messages, only: [:index] do
    resources :message_users, only: [:update]
  end
end
