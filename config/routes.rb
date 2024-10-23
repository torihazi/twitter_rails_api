# frozen_string_literal: true

Rails.application.routes.draw do
  resources :tasks

  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?

  namespace :api do
    namespace :v1 do
      devise_for :users, controllers: {
        sessions: 'api/v1/users/sessions',
        registrations: 'api/v1/users/registrations',
        confirmations: 'api/v1/users/confirmations'
      }
      resources :tweets
      post 'images', to: 'images#create'
    end
  end
end
