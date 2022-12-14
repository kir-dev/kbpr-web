Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resources :groups
  resources :orders
  resources :articles
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  resources :users, only: [:index, :show]

  resources :pages do
    get :admin, on: :collection
    get :profile, on: :collection
  end
  root "pages#home"
end
