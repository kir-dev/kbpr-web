Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :order_items
  resources :items
  resources :groups
  resources :orders do
    patch :finalize, on: :member
    post :complete, on: :member
    get :my_orders, on: :collection, as: :my
  end

  resources :articles
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  resources :users, except: :destroy

  resources :pages do
    get :admin, on: :collection
    get :profile, on: :collection
  end
  resources :kwc, only:[:update, :index] do
    get :current, on: :collection, as: :current
  end
  resources :statistics, only: [:index] do
    get :for_group, on: :collection
  end
  root "pages#home"
end
