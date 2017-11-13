require 'rails_helper'

RSpec.describe Api::V1::Users::IssuesController, type: :controller do
  let(:user) { create(:user) }
  before { sign_in(user) }

  describe '#index' do
    let(:issues) { double(:issues) }
    let(:ordered_issues) { double(:ordered_issues) }
    let(:paginated_issues) { double(:paginated_issues) }

    before { allow_any_instance_of(User).to receive(:issues).and_return(issues) }
    before { allow(issues).to receive(:recent).and_return(ordered_issues) }
    before { allow(ordered_issues).to receive(:page).and_return(paginated_issues) }
    before { allow(paginated_issues).to receive(:per).and_return(paginated_issues) }

    subject { get :index, format: :json }

    it { is_expected.to have_http_status(200) }

    it 'returns paginated and ordered issues' do
      subject

      expect(issues).to have_received(:recent)
      expect(ordered_issues).to have_received(:page).with(0)
      expect(paginated_issues).to have_received(:per).with(25)
    end

    context 'when filtered by state' do
      let(:filtered_issues) { double(:filtered_issues) }

      before { allow(issues).to receive(:by_state).and_return(filtered_issues) }
      before { allow(filtered_issues).to receive(:recent).and_return(ordered_issues) }

      subject { get :index, params: { by_state: 'resolved' }, format: :json }

      it 'returns filtered issues' do
        subject

        expect(issues).to have_received(:by_state).with('resolved')
        expect(filtered_issues).to have_received(:recent)
        expect(ordered_issues).to have_received(:page).with(0)
        expect(paginated_issues).to have_received(:per).with(25)
      end
    end
  end

  describe '#create' do
    let(:issue) { double(:issue) }
    let(:issues) { double(:issues) }
    let(:attributes) { attributes_for(:issue) }

    before { allow_any_instance_of(User).to receive(:issues).and_return(issues) }
    before { allow(issues).to receive(:create).and_return(issue) }
    before { allow(issue).to receive(:persisted?).and_return(true) }

    subject { post :create, params: { issue: attributes }, format: :json }

    it { is_expected.to have_http_status(201) }

    it 'creates only by permitted params' do
      subject

      expect(issues).to have_received(:create).with(
        ActionController::Parameters.new({summary: attributes[:summary], description: attributes[:description]})
          .permit(:summary, :description)
      )
    end
  end

  describe '#update' do
    let(:issue) { double(:issue) }
    let(:issues) { double(:issues) }
    let(:attributes) { attributes_for(:issue) }

    before { allow_any_instance_of(User).to receive(:issues).and_return(issues) }
    before { allow(issues).to receive(:find).and_return(issue) }
    before { allow(issue).to receive(:update).and_return(true) }

    subject { put :update, params: { issue: attributes, id: 3 }, format: :json }

    it { is_expected.to have_http_status(200) }

    it 'creates only by permitted params' do
      subject

      expect(issues).to have_received(:find).with('3')
      expect(issue).to have_received(:update).with(
        ActionController::Parameters.new({summary: attributes[:summary], description: attributes[:description]})
          .permit(:summary, :description)
      )
    end
  end
end
