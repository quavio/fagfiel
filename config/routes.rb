PortalInafag::Application.routes.draw do
  get "general/contact", :as => :contact
  post "general/contact"

  resources :users
  resources :resellers do
    resources :seasonal_purchase_expectations, :path => "seasonal_purchase_expectations/:year/:month"
    resources :seasonal_purchase_histories, :path => "seasonal_purchase_histories/:year/:month"
  end
  resources :orders
  resources :freebies
  resources :products

  devise_for :users, :path => '/', :path_names => { :sign_in => 'login', :sign_out => 'logout' }

  match "miv" => "miv#index"

  root :to => "freebies#index"
end
