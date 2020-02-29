Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#index'
  get '/about', to: 'home#about'
  get '/login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  get '/complete_task', to: 'tasks#complete'

  get '/admin/:id/edit', to: 'users#admin_edit'

  resources :details, only: [:create, :destroy, :update]
  resources :comments, only: [:create, :destroy]
  resource :user, only: [:new, :create, :edit, :update, :show, :destroy]
  resources :users, only: [:index, :edit, :update, :destroy]
  resources :tasks, only: [:show, :new, :create, :edit, :update, :destroy]
  
end
