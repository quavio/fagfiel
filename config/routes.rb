PortalInafag::Application.routes.draw do
  resources :users
  resources :resellers
  resources :freebies

  devise_for :users, :path => '/', :path_names => { :sign_in => 'login', :sign_out => 'logout' }

  match "miv" => "miv#index"

  root :to => "home#index"
end
