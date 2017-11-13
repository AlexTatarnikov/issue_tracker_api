require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource 'Manager' do
  let(:manager) { create :manager }
  let(:token) { manager.authentication_token }

  header 'accept', 'application/json'
  header 'Authorization', :token

  post 'api/v1/managers/issues/:id/assigns' do
    let(:issue) { create :issue, manager_id: nil }
    let(:id) { issue.id }

    example_request 'Assign issue' do
      expect(status).to eq(200)
      expect(response_body).to eq({data: {
        id: issue.id,
        type: 'issue',
        summary: issue.summary,
        description: issue.description,
        state: 'pending'
      }}.to_json)
    end
  end

  post 'api/v1/managers/issues/:id/assigns' do
    let(:issue) { create :issue }
    let(:id) { issue.id }

    example_request 'Assign issue - error - already assigned' do
      expect(status).to eq(404)
    end
  end

  delete 'api/v1/managers/issues/:id/assigns' do
    let(:issue) { create :issue, manager: manager }
    let(:id) { issue.id }

    example_request 'Unassign issue' do
      expect(status).to eq(204)
    end
  end

  delete 'api/v1/managers/issues/:id/assigns' do
    let(:issue) { create :issue }
    let(:id) { issue.id }

    example_request 'Unassign - error - not assigned to manager' do
      expect(status).to eq(404)
    end
  end

  delete 'api/v1/managers/issues/:id/assigns' do
    let(:issue) { create :issue, manager: manager, state: 'in_progress' }
    let(:id) { issue.id }

    example_request 'Unassign - error - in active state' do
      expect(status).to eq(422)
    end
  end
end
