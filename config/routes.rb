Rails.application.routes.draw do

  resources :favorites
  resources :contacts
  resources :posts
  resources :events, only:[:index, :destroy]
  
  get 'admins/eventnew', to: 'admins#eventnew'
  post 'admins/eventnew', to: 'admins#eventcreate'
  post 'admins/eventcreate', to: 'admins#eventcreate'
  
  get 'comments/new'
  post '/comments', to: 'comments#create'
  
  get 'styles/new'

  get 'password_resets/new'
  get 'password_resets/edit'
  get 'users/new'

  root 'static_pages#home'

  get  '/help',    to: 'static_pages#help'
  get  '/about',   to: 'static_pages#about'
  get  '/contact', to: 'static_pages#contact'
  get  'whatsikebana', to: 'static_pages#whatsikebana'
  get  '/signup',  to: 'users#new'
  post '/signup',  to: 'users#create'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :styles
  
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

end
