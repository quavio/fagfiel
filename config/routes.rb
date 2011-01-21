PortalInafag::Application.routes.draw do
  resources :resellers

  match "miv" => "miv#index"

  devise_for :users

  root :to => "home#index"
end
