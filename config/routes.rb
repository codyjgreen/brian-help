Rails.application.routes.draw do
  Rails.application.routes.draw do
    namespace :api do
      resources :games, only: [:index, :create, :update]
      resources :players, only: [:index, :create, :update, :destroy]
    end
  end

  mount ActionCable.server => '/cable'
end
