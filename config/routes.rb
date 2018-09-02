Rails.application.routes.draw do
  resource :avatar
  root to: "avatars#show"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resource :auth, only: %i[create]
      resources :posts
    end
  end
end
