Rails.application.routes.draw do
  concern :paginatable do
    get 'page/:page', action: :index, on: :collection
  end

  resources :books, concerns: [:paginatable]
  resources :sessions, only: [:new, :create] do
    get :logout, on: :collection
  end

  root to: 'books#index'
end
