Codeforla::Application.routes.draw do
  get "logout" => "sessions#destroy"
  get "login" => "sessions#new"
  post "login" => "sessions#create"
  root to: 'home#index'

  resources :projects

  namespace :admin do
    root to: "base#index"
  end
end
