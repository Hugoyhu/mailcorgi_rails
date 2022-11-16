Rails.application.routes.draw do
  get 'main/index', to: 'main#index'
  get 'tracking/:id', to: 'tracking#index'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
