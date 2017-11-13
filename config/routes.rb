Rails.application.routes.draw do
  mount Apitome::Engine, at: '/api/docs'

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

        resources :issues, only: [:index]
      end
    end
  end
end
