# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    patch 'user' => 'devise_invitable/registrations#update', as: nil
    put 'user' => 'devise_invitable/registrations#update',
        as: :update_user_registration
    delete 'user' => 'devise_invitable/registrations#destroy',
           as: :destroy_user_registration
    patch 'password' => 'devise/passwords#update'
    put 'password' => 'devise/passwords#update', as: :update_user_password
    resources :users
    root to: 'pages#home'
    get 'pages/show'
  end
end
