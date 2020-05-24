Rails.application.routes.draw do

  resources :favorites
  resources :contacts
  resources :posts
  resources :events, only: [:index, :show]

  get 'admins/eventsindex', to: 'admins#eventindex'  
  get 'admins/eventnew', to: 'admins#eventnew'
  post 'admins/eventcreate', to: 'admins#eventcreate'
  get 'admins/eventedit/:id', to: 'admins#eventedit', as:'admins_eventedit'
  delete 'admins/events/:id', to: 'admins#eventdestroy', as:'admins_eventdelete'
  get 'admins/postsindex', to: 'admins#postindex'
  get 'admins/postedit/:id', to: 'admins#postedit', as:'admins_postedit'
  delete 'admins/posts/:id', to: 'admins#postdestroy' ,as:'admins_postdelete'
  get 'admins/contactsindex', to: 'admins#contactindex'
  get 'admins/contacts/:id/edit', to: 'admins#contactedit', as:'admins_contactedit'
  patch 'admins/contacts/:id/update', to: 'admins#contactupdate', as:'admins_contactupdate'
  delete 'admins/contact/:id', to: 'admins#contactdestroy', as:'admins_contactdelete'
  get 'admins/eventimagesindex', to: 'admins#eventimageindex'
  get 'admins/eventimagenew', to: 'admins#eventimagenew'
  post 'admins/eventimagecreate', to: 'admins#eventimagecreate'
  delete 'admins/eventimage/:id', to: 'admins#eventimagedestroy', as:'admins_eventimagedelete'

  get 'auth/:provider/callback', to: 'sessions#t_create'
  
  get 'comments/new'
  post '/comments', to: 'comments#create'
  
  get 'styles/new'

  get 'password_resets/new'
  get 'password_resets/edit'
  get 'users/new'

  root 'static_pages#home2'

  get  '/help',    to: 'static_pages#help'
  get  '/about',   to: 'static_pages#about'
  get  '/contact', to: 'static_pages#contact'
  get  'whatsikebana', to: 'static_pages#whatsikebana'
  get  '/terms', to:'static_pages#terms'
  get  '/privacy', to:'static_pages#privacy'
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
