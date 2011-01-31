PortalInafag::Application.routes.draw do
  resources :users
  resources :resellers
  resources :freebies

  devise_for :users

  match "miv" => "miv#index"

  root :to => "home#index"
end
