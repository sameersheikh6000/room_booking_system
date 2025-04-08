Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  resources :rooms, only: [:index, :show]
  resources :bookings, only: [:index, :new, :create] do
    member do
      post :cancel
    end
  end
  root "bookings#index"

  namespace :admin do
    resources :dashboard, only: [:index]
    resources :rooms
    resources :bookings, only: [:index] do
      member do
        post :approve
      end
    end
  end
end
