Rails.application.routes.draw do
  resources :images, only: [:index, :create, :destroy]

  root 'images#index'
end
