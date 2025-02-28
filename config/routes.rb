Rails.application.routes.draw do
  devise_for :users, path: 'auth', path_names: { sign_in: 'login', sign_out: 'logout', password: 'secret', confirmation: 'verification', unlock: 'unblock', registration: 'register', sign_up: 'cmon_let_me_in' }
  # Use Devise for authentication

  # ✅ Redirect to Devise's sign-in page correctly
  root to: "books#index"
  get "up" => "rails/health#show", as: :rails_health_check
  resources :books
end
