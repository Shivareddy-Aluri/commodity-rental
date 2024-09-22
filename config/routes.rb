Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  post 'user/signup', to: 'users#create'

  namespace :api do
    resources :commodities, only: [] do
      collection do
        post :list
        get :list, to: 'commodities#get_list'
        post :bid, to: 'commodities#create_bid'
        post :re_bid, to: 'commodities#re_bid'
        get :my_commodities, to: 'commodities#list_my_commodities'
        post :re_list, to: 'commodities#re_list'
      end

      member do
        get :get_bids, to: 'commodities#get_bids'
      end
    end
  end
end
