PortalInafag::Application.routes.draw do
  get "miv/index"

  devise_for :users

  root :to => "home#index"
end
