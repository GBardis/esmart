Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }

  constraints subdomain: 'api' do
    namespace :api, path: nil, defaults: { format: :json } do
      resources :games, only: [:index]
    end
  end

  resource :dashboard, only: :show

  resources :games, only: [:index] do
    post :add, on: :member
    post :remove, on: :member
  end

  resources :matches, only: %i[index new create]

  root to: 'dashboards#show'
end
