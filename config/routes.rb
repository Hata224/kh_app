# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'pages#home'
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
  end

  get 'pages/show'

  resources :users, only: %i[index show] do
    member do
      get :following, :followers
    end
  end

  resources :posts do
    resources :comments
    resources :favorites, only: %i[create destroy]
  end

  resources :relationships, only: %i[create destroy]
end
