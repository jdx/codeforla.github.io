Codeforla::Application.routes.draw do
  get "login" => "sessions#new"
  root to: 'home#index'
end
