Rails.application.routes.draw do
  
  root to: 'homes#top'
  get 'about' => 'homes#about'
  
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
  }

  devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
  }
  
  resources :customers do
    member do
      get :follows, :followers
    end
      resource :relationships, only: [:create, :destroy]
  end
  resources :posts
  get '/favicon.ico', to: redirect('/path/to/favicon.ico')
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
