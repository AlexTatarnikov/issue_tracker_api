require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource 'User' do
  header 'accept', 'application/json'

  post 'api/v1/users/tokens' do
    with_options scope: :auth, required: true do
      parameter :email, 'Email'
      parameter :password, 'Password'
    end

    let!(:user)  { create :user, email: 'batman@gotham.com' }
    let(:email) { 'batman@gotham.com' }
    let(:password) { 'password' }


    example_request 'Get auth token' do
      expect(status).to eq(201)
    end

    example_request 'Get auth token - errors', auth: {email: 'sasha@grey.com'} do
      expect(status).to eq(404)
    end
  end
end
