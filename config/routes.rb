Rails.application.routes.draw do

  get "/" => "homes#top"
  get "about" => "homes#about"

  get "posts/index" => "posts#index"
  get "posts/new" => "posts#new"
  get "posts/:id" => "posts#show"
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
