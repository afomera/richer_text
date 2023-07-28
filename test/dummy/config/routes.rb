Rails.application.routes.draw do
  resources :posts
  mount RicherText::Engine => "/richer_text"
end
