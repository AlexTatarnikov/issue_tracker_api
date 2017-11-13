require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource 'Manager' do
  let(:manager) { create :manager }
  let(:token) { manager.authentication_token }

  header 'accept', 'application/json'
  header 'Authorization', :token

  get 'api/v1/managers/issues' do
    let!(:issue1) { create :issue, created_at: Time.now.yesterday }
    let!(:issue2) { create :issue, created_at: Time.now.tomorrow }

    parameter :by_state, 'Filter issues by state'

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
end
