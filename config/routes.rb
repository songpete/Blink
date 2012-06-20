Blink::Application.routes.draw do
  devise_for :users

  root :to => 'pages#home'

  resources :users
  resources :sites

  # pages
  get '/about' => 'pages#about'
  get '/contact' => 'pages#contact'

  get '/userlinks' => 'sites#userlinks'

  # Send unknown routes to redirects controller.
  match '*path' => 'redirects#show'

  # redirect random strings to a controller.
  # map.connect '*', :controller => 'redirects', :action => 'show'

end
