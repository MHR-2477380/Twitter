Rails.application.routes.draw do

  get "/" => "homes#top"
  get "about" => "homes#about"

  get "posts/index" => "posts#index"
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
