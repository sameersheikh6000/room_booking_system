Rails.application.routes.draw do
  root "bookings#index"

  devise_for :users, controllers: {
    sessions: "users/sessions",
    registrations: "users/registrations"
  }

  resources :rooms, only: %i[index show]
  resources :bookings, only: %i[index new create] do
    member do
      post :cancel
    end
  end

  namespace :admin do
    resources :dashboard, only: %i[index]
    resources :rooms
    resources :bookings, only: %i[index destroy] do
      member do
        post :approve
      end
    end
  end
end
