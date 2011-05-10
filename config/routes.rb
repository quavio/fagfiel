PortalInafag::Application.routes.draw do
  get "general/contact", :as => :contact
  post "general/contact"
  get "general/documents", :as => :documents

  resources :users
  resources :resellers do
    resources :seasonal_purchase_expectations, :path => "seasonal_purchase_expectations/:year/:month"
    resources :seasonal_purchase_histories, :path => "seasonal_purchase_histories/:year/:month"
  end
  resources :orders
  resources :freebies
  resources :products

  # Email template routes
  match "/mailer/confirmation_instructions" => "mailer#confirmation_instructions"
  match "/mailer/contact" => "mailer#contact"
  match "/mailer/new_order" => "mailer#new_order"
  match "/mailer/new_expectation" => "mailer#new_expectation"
  match "/mailer/user_changed" => "mailer#user_changed"
  match "/mailer/update_expectation" => "mailer#update_expectation"
  match "/mailer/destroyed_expectation" => "mailer#destroyed_expectation"

  devise_for :users, :path => '/', :path_names => { :sign_in => 'login', :sign_out => 'logout' }

  root :to => "freebies#index"
end
