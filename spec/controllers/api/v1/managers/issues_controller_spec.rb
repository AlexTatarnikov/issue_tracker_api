require 'rails_helper'

RSpec.describe Api::V1::Managers::IssuesController, type: :controller do
  let(:manager) { create(:manager) }
  before { sign_in(manager) }

  describe '#index' do
    let(:ordered_issues) { double(:ordered_issues) }
    let(:paginated_issues) { double(:paginated_issues) }

    before { allow(Issue).to receive(:recent).and_return(ordered_issues) }
    before { allow(ordered_issues).to receive(:page).and_return(paginated_issues) }
    before { allow(paginated_issues).to receive(:per).and_return(paginated_issues) }

    subject { get :index, format: :json }

    it { is_expected.to have_http_status(200) }

    it 'returns paginated and ordered issues' do
      subject

      expect(Issue).to have_received(:recent)
      expect(ordered_issues).to have_received(:page).with(0)
      expect(paginated_issues).to have_received(:per).with(25)
    end

    context 'when filtered by state' do
      let(:filtered_issues) { double(:filtered_issues) }

      before { allow(Issue).to receive(:by_state).and_return(filtered_issues) }
      before { allow(filtered_issues).to receive(:recent).and_return(ordered_issues) }

      subject { get :index, params: { by_state: 'resolved' }, format: :json }

      it 'returns filtered issues' do
        subject

        expect(Issue).to have_received(:by_state).with('resolved')
        expect(filtered_issues).to have_received(:recent)
        expect(ordered_issues).to have_received(:page).with(0)
        expect(paginated_issues).to have_received(:per).with(25)
      end
    end
  end
end
