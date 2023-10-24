Rails.application.routes.draw do
  get 'posts/new'
  get 'posts/index'
  get 'posts/show'
  root to: 'homes#top'
  get 'about' => 'homes#about'

  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
  }

  devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
  }

  resources :post
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
