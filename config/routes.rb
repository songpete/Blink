Blink::Application.routes.draw do
  devise_for :admins

  devise_for :users

  root :to => 'pages#home'

  resources :users do
    resources :sites, only: [:index]
  end

  resources :sites

  # pages
  get '/about' => 'pages#about'
  get '/contact' => 'pages#contact'

  get '/userlinks' => 'sites#userlinks'

  match '*path' => 'redirects#show'
end
