require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource 'User' do
  let(:user) { create :user }
  let(:token) { user.authentication_token }

  header 'accept', 'application/json'
  header 'Authorization', :token

  get 'api/v1/users/issues' do
    let!(:issue1) { create :issue, created_at: Time.now.yesterday, requester: user }
    let!(:issue2) { create :issue, created_at: Time.now.tomorrow, requester: user }

    example_request 'Issues list' do
      expect(status).to eq(200)
      expect(response_body).to eq({data: [
        {
          id: issue2.id,
          type: 'issue',
          summary: issue2.summary,
          description: issue2.description
        },
        {
          id: issue1.id,
          type: 'issue',
          summary: issue1.summary,
          description: issue1.description
        }
      ]}.to_json)
    end
  end

  get 'api/v1/users/issues/:id' do
    let(:issue) { create :issue, requester: user }
    let(:id) { issue.id }

    example_request 'Issue details' do
      expect(status).to eq(200)
      expect(response_body).to eq({
                                    data: {
                                      id: issue.id,
                                      type: 'issue',
                                      summary: issue.summary,
                                      description: issue.description
                                    }
                                  }.to_json)
    end
  end

  post 'api/v1/users/issues' do
    with_options scope: :issue do
      parameter :summary, 'Summary', required: true
      parameter :description, 'Description'
    end

    let(:summary) { 'Issues List' }
    let(:description) { 'A user should be able to update issue' }

    example_request 'Create issue' do
      expect(status).to eq(201)
    end
  end

  post 'api/v1/users/issues' do
    with_options scope: :issue do
      parameter :summary, 'Summary', required: true
      parameter :description, 'Description'
    end

    let(:description) { 'A user should be able to update issue' }

    example_request 'Create issue - errors' do
      expect(status).to eq(422)
    end
  end

  put 'api/v1/users/issues/:id' do
    let(:issue) { create :issue, requester: user }
    let(:id) { issue.id }

    with_options scope: :issue do
      parameter :summary, 'Summary'
      parameter :description, 'Description'
    end

    let(:summary) { 'Issues List' }
    let(:description) { 'A user should be able to update issue' }

    example_request 'Update issue' do
      expect(status).to eq(200)
      expect(response_body).to eq({
                                    data: {
                                      id: issue.id,
                                      type: 'issue',
                                      summary: 'Issues List',
                                      description: 'A user should be able to update issue'
                                    }
                                  }.to_json)
    end
  end

  put 'api/v1/users/issues/:id' do
    let(:issue) { create :issue, requester: user }
    let(:id) { issue.id }

    with_options scope: :issue do
      parameter :summary, 'Summary'
      parameter :description, 'Description'
    end

    let(:summary) { nil }

    example_request 'Update issue - errors' do
      expect(status).to eq(422)
    end
  end

  delete 'api/v1/users/issues/:id' do
    let(:issue) { create :issue, requester: user }
    let(:id) { issue.id }

    example_request 'Destroy issue' do
      expect(status).to eq(204)
    end
  end
end
