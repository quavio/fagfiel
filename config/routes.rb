PortalInafag::Application.routes.draw do
  get "general/contact", :as => :contact
  post "general/contact"

  resources :users
  resources :resellers do
    resources :purchase_expectations, :path => "purchase_expectations/:year/:month"
  end
  resources :orders
  resources :freebies

  devise_for :users, :path => '/', :path_names => { :sign_in => 'login', :sign_out => 'logout' }

  match "miv" => "miv#index"

  root :to => "freebies#index"
end
