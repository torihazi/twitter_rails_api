# frozen_string_literal: true

Rails.application.routes.draw do
  resources :tasks

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

  namespace :api do
    namespace :v1 do
      devise_for :users, controllers: {
        sessions: 'api/v1/users/sessions',
        registrations: 'api/v1/users/registrations',
        confirmations: 'api/v1/users/confirmations'
      }
    end
  end
end
