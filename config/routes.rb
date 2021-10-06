# frozen_string_literal: true

Rails.application.routes.draw do
  root 'posts#index'
  devise_for :users,
             path: '',
             path_names: { sign_in: 'login', sign_out: 'logout', edit: 'profile', sign_up: 'registration' },
             controllers: { registrations: 'registrations' }

  resources :users, only: [:show] do
    post 'follow', to: 'users#follow_user', as: :follow, on: :collection
    post 'unfollow', to: 'users#unfollow_user', as: :unfollow, on: :collection
  end

  resources :posts do
    resources :likes, only: %i[create destroy], shallow: true
    resources :comments, except: %i[new show], shallow: true
    resources :followership, only: %i[create destroy], shallow: true
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
