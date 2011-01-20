PortalInafag::Application.routes.draw do
  match "miv" => "miv#index"

  devise_for :users

  root :to => "home#index"
end
