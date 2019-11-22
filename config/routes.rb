Rails.application.routes.draw do
  devise_for :users

  root to: 'pages#index'
  get 'pages/show'
end
