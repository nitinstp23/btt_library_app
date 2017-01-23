Rails.application.routes.draw do
  concern :paginatable do
    get 'page/:page', action: :index, on: :collection
  end

  resources :books, concerns: [:paginatable] do
    resources :book_allocations, only: [:new, :create]
  end

  resources :sessions, only: [:new, :create] do
    get :logout, on: :collection
  end

  root to: 'books#index'
end
