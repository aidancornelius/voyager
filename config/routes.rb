Voyager::Engine.routes.draw do
  resources :courses
  get 'notifications', to: 'notifications#index'
  post 'notifications/check_subscribed_status', to: 'notifications#check_subscribed_status'
  delete 'notifications/remove_subscription', to: 'notifications#remove_subscription'
  post 'notifications/add_subscription', to: 'notifications#add_subscription'
  resources :media_storages
  resources :landings
  resources :images
  get 'ai/:id', to: 'images#reveal'
  resources :completions
  get 'certificate', to: 'certificate#index'
  get 'pdcertificate', to: 'certificate#generate'
  get 'dashboard', to: 'dashboard#index'
  resources :messages
  resources :lesson_components
  resources :replies do
      post 'star'
  end
  get 'modules', to: 'units#index'
  get 'modules/:module_slug/:component_slug', to: 'units#lesson_component'
  get 'units', to: 'units#index'
  get 'search/:q', to: 'search#tags'
  resources :lessons
  get 'admin', to: 'admin#index'
  resources :page_sections
  resources :pages
  get '/about', to: 'pages#render_page', id: 'about'
  get 'l/:landing_slug', to: 'splash#landing'
  post 'email_subscribe', to: 'splash#subscribe'
  resource :inbox, controller: 'inbox', only: [:show, :create]
end
