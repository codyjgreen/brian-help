Rails.application.routes.draw do
  Rails.application.routes.draw do
    namespace :api do
      resources :games, only: [:index, :create, :update]
    end
  end

  mount ActionCable.server => '/cable'
end
