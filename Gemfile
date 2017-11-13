source 'https://rubygems.org'

ruby '2.4.2'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.1.4'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.7'
gem 'kaminari'

#API Staff
gem 'responders'
gem 'active_model_serializers', '~> 0.10.0'
gem 'has_scope'

#Authentication
gem 'bcrypt'
gem 'knock'

# API Documentation
gem 'apitome'
gem 'rspec_api_documentation'

group :development, :test do
  gem 'rails_dt'
  gem 'dotenv-rails'
end

group :development do
  gem 'listen', '~> 3.0.5'
  gem 'letter_opener'
end

group :test do
  gem 'rspec-rails'
  gem 'capybara'
  gem 'shoulda-matchers'
  gem 'database_flusher'
  gem 'nyan-cat-formatter'
  gem 'simplecov', require: false
  gem 'factory_bot_rails'
  gem 'faker'
end

