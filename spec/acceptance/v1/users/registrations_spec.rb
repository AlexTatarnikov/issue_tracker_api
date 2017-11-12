require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource 'User' do
  header 'accept', 'application/json'

  post 'api/v1/users/registrations' do
    with_options scope: :sign_up, required: true do
      parameter :email, 'Email'
      parameter :password, 'Password'
      parameter :password_confirmation, 'Password Confirmation'
    end

    let(:email) { 'batman@gotham.com' }
    let(:password) { 'password' }
    let(:password_confirmation) { 'password' }


    example_request 'Creating a user account' do
      expect(status).to eq(200)
    end

    example_request 'Creating a user account - errors', sign_up: {password_confirmation: ''} do
      expect(status).to eq(422)
    end
  end
end
