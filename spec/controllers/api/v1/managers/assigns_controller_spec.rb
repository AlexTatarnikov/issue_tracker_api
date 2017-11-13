require 'rails_helper'

RSpec.describe Api::V1::Managers::AssignsController, type: :controller do
  let(:manager) { create(:manager) }
  before { sign_in(manager) }

  describe '#create' do
    let(:unassigned_issues) { double(:unassigned_issues) }
    let(:issue) { double(:issue) }

    before { allow(Issue).to receive(:unassigned).and_return(unassigned_issues) }
    before { allow(unassigned_issues).to receive(:find).and_return(issue) }
    before { allow(issue).to receive(:update) }

    subject { post :create, params: { id: 3 }, format: :json }

    it { is_expected.to have_http_status(200) }

    it 'assigns issue to current manager' do
      subject

      expect(Issue).to have_received(:unassigned)
      expect(unassigned_issues).to have_received(:find).with('3')
      expect(issue).to have_received(:update).with(manager_id: manager.id)
    end
  end

  describe '#destroy' do
    let(:manager_issues) { double(:manager_issues) }
    let(:issue) { double(:issue) }

    before { allow_any_instance_of(Manager).to receive(:issues).and_return(manager_issues) }
    before { allow(manager_issues).to receive(:find).and_return(issue) }
    before { allow(issue).to receive(:update).and_return(true)  }

    subject { delete :destroy, params: { id: 3 }, format: :json }

    it { is_expected.to have_http_status(204) }

    it 'unassigns issue from current manager' do
      subject

      expect(manager_issues).to have_received(:find).with('3')
      expect(issue).to have_received(:update).with(manager_id: nil)
    end
  end
end
