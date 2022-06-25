require 'sidekiq/web'
require 'sidekiq-scheduler/web'

Rails.application.routes.draw do
  resources :newsletters
  resources :subscribers do
    collection do
      get :confirm
    end
  end
  # devise_for :users
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    # confirmations: 'users/confirmations',
    passwords: 'users/passwords',
    # registrations: 'users/registrations',
    unlocks: 'users/unlocks'
  }, skip: [:registrations, :confirmations]

  authenticate :user do
    mount Sidekiq::Web => '/sidekiq'
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "home#page"
  post '/', to: 'home#subscribe_user', as: :subscribe_user
end
