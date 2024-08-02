Rails.application.routes.draw do
  devise_for :views
  # route generate automatically by devise
  devise_for :users
  get "up" => "rails/health#show", as: :rails_health_check

  # get "/blog_posts/new", to: "blog_posts#new", as: :new_blog_post
  # get "/blog_posts/:id", to: "blog_posts#show", as: :blog_post
  # get "/blog_posts/:id/edit", to: "blog_posts#edit", as: :edit_blog_post
  # post "/blog_posts", to: "blog_posts#create"
  # patch "/blog_posts/:id", to: "blog_posts#update"
  # delete "/blog_posts/:id", to: "blog_posts#destroy"
  resources :blog_posts
  
  # Defines the root path route ("/")
  root "blog_posts#index"
end
