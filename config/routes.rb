Rails.application.routes.draw do
  root to: 'home_pages#home'
  get 'search' , to: 'search#index'
end
