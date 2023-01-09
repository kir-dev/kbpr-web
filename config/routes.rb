Rails.application.routes.draw do
  resources :order_items
  resources :items
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resources :groups
  resources :orders do
    get :new_item, on: :member
    post :create_item, on: :member
    post :update_item, on: :member
    get :all_item, on: :member

  end
  resources :articles
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  resources :users, only: [:index, :show]

  resources :pages do
    get :admin, on: :collection
    get :profile, on: :collection
  end
  root "pages#home"
end
