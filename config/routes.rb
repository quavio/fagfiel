PortalInafag::Application.routes.draw do
  get "general/contact", :as => :contact
  post "general/contact"
  get "general/faq", :as => :faq

  resources :users
  resources :resellers do
    resources :seasonal_purchase_expectations, :path => "seasonal_purchase_expectations/:year/:month"
  end
  resources :orders
  resources :freebies
  resources :courses

  devise_for :users, :path => '/', :path_names => { :sign_in => 'login', :sign_out => 'logout' }

  match "miv" => "miv#index"

  root :to => "freebies#index"
end
