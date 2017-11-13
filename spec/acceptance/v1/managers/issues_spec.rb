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
          description: issue2.description,
          state: 'pending'
        },
        {
          id: issue1.id,
          type: 'issue',
          summary: issue1.summary,
          description: issue1.description,
          state: 'pending'
        }
      ]}.to_json)
    end
  end

  put 'api/v1/managers/issues/:id' do
    let(:issue) { create :issue, manager: manager }
    let(:id) { issue.id }

    with_options scope: :issue do
      parameter :state, "State. Allowed: #{Issue.states.keys}"
    end

    let(:state) { 'in_progress' }

    example_request 'Update issue' do
      expect(status).to eq(200)
      expect(response_body).to eq({
                                    data: {
                                      id: issue.id,
                                      type: 'issue',
                                      summary: issue.summary,
                                      description: issue.description,
                                      state: 'in_progress'
                                    }
                                  }.to_json)
    end
  end
end
