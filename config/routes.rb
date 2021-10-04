# frozen_string_literal: true

Rails.application.routes.draw do
  root 'posts#index'
  devise_for :users,
             path: '',
             path_names: { sign_in: 'login', sign_out: 'logout', edit: 'profile', sign_up: 'registration' },
             controllers: { registrations: 'registrations' }
  resources :users, only: [:show]
  resources :posts do
    resources :likes, only: %i[create destroy], shallow: true
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
