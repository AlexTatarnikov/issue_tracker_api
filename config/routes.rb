Rails.application.routes.draw do
  mount Apitome::Engine, at: '/api/docs'
end
