Rails.application.routes.draw do

  root 'home#index'

  namespace :api do
    namespace :v1 do
      resources :games, only: [:index, :show, :new], param: :token, default: { format: 'json' } do
        collection do
          post :mark
        end
      end
    end
  end

  mount ActionCable.server => '/cable'

  get '*path', to: 'home#index'
end
