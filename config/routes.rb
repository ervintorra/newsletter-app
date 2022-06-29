require 'sidekiq/web'
require 'sidekiq-scheduler/web'

Rails.application.routes.draw do
  authenticate :user do
    mount Sidekiq::Web => '/sidekiq'
  end

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    # confirmations: 'users/confirmations',
    passwords: 'users/passwords',
    # registrations: 'users/registrations',
    unlocks: 'users/unlocks'
  }, skip: %i[registrations confirmations]

  resources :newsletters
  resources :subscribers do
    collection do
      get :confirm
    end
  end

  root 'home#page'
  post '/', to: 'home#subscribe_user', as: :subscribe_user
end
