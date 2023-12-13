Rails.application.routes.draw do
  resources :fiscal_periods
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :order_items do
    get :order_image_input, on: :collection
  end
  resources :items
  resources :groups
  resources :orders do
    patch :finalize, on: :member
    post :complete, on: :member
    get :my_orders, on: :collection, as: :my
  end

  resources :articles
  resources :funky_texts
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  resources :users, except: :destroy

  resources :pages do
    get :admin, on: :collection
    get :profile, on: :collection
  end
  resources :kwcs, only: [:index] do
    get :current, on: :collection
    patch :current, on: :collection, as: :update_current, to: 'kwcs#update_current'
  end
  resources :statistics do
    get :for_groups, on: :collection
    get :for_users, on: :collection
    get :for_group, on: :collection
    get :for_group_member, on: :collection
  end

  get '/statistics_users', to: 'statistics#for_user_index', as: :statistics_users
  get '/statistics_users/:user_id/:fiscal_period_id', to: 'statistics#for_user', as: :statistics_for_user
  root "pages#home"
end
