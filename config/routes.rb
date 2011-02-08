PortalInafag::Application.routes.draw do
  get "general/contact", :as => :contact

  resources :users
  resources :resellers
  resources :orders
  resources :freebies

  devise_for :users, :path => '/', :path_names => { :sign_in => 'login', :sign_out => 'logout' }

  match "miv" => "miv#index"

  root :to => "freebies#index"
end
