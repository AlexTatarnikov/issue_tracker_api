Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :users do
        post 'tokens' => 'tokens#create'
        post 'registrations' => 'registrations#create'

        resources :issues
      end

      namespace :managers do
        post 'tokens' => 'tokens#create'
        post 'registrations' => 'registrations#create'

        resources :issues, only: [:index, :update] do
          member do
            resource :assigns, only: [:create, :destroy]
          end
        end
      end
    end
  end

  mount Apitome::Engine, at: '/'
end
