# frozen_string_literal: true

Rails.application.routes.draw do
  root 'posts#index'
  get :search, to: 'users#search'
  devise_for :users,
             path: '',
             path_names: { sign_in: 'login', sign_out: 'logout', edit: 'profile', sign_up: 'registration' },
             controllers: { registrations: 'registrations' }

  resources :users, only: %i[show index] do
    post :follow, to: 'followerships#create', on: :collection
    post :unfollow, to: 'followerships#destroy', on: :collection
    post :accept_request, to: 'followerships#update', on: :collection
    post :reject_request, to: 'followerships#reject', on: :collection
    get :requests_pending, shallow: true
  end

  resources :posts do
    resources :likes, only: %i[create destroy], shallow: true
    resources :comments, except: %i[new show], shallow: true
  end

  resources :stories, only: %i[index create destroy show]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
