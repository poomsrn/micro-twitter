Rails.application.routes.draw do
  resources :likes
  resources :follows
  resources :posts
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get "main" ,to: "users#main"
  post "main" ,to: "users#login"
  get "feed", to: "users#feed"
  get "newById", to: "posts#newById"
  get "register", to: "users#register"
  get "/profile/:name", to: "users#profile"
  get "/follows/newFollow/:user_id", to: "follows#newFollow"
  get "/follows/unFollow/:user_id", to: "follows#unFollow"
  get "/likes/newLike/:post_id", to: "likes#newLike"
  get "/likes/unLike/:post_id", to: "likes#unLike"
end
