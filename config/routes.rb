Rails.application.routes.draw do

	mount ActionCable.server => '/cable'
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'static_pages#home'

  post 'search', to: 'search#perform'
end
