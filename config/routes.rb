Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :order_items do
    get :stats, on: :collection
    get :stats_for_group, on: :collection
  end
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

  resources :pages, only: [] do
    get :admin, on: :collection
    get :profile, on: :collection
    get :kwc, on: :collection
    post :kwc_update, on: :collection
    get :kwc_list, on: :collection
  end
  root "pages#home"
end
