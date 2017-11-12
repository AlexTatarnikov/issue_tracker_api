Rails.application.routes.draw do
  mount Apitome::Engine, at: '/api/docs'

  namespace :api do
    namespace :v1 do
      namespace :users do
        post 'tokens' => 'tokens#create'
        post 'registrations' => 'registrations#create'
      end

      namespace :managers do
        post 'tokens' => 'tokens#create'
        post 'registrations' => 'registrations#create'
      end
    end
  end
end
