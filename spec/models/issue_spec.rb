require 'rails_helper'

RSpec.describe Issue, type: :model do
  it { is_expected.to belong_to(:requester).class_name(User) }
  it { is_expected.to belong_to(:manager) }

  it { is_expected.to validate_presence_of :summary }
  it { is_expected.to define_enum_for(:state).with([:pending, :in_progress, :resolved]) }

  describe '#recent' do
    let!(:issue1) { create :issue, created_at: Time.now.yesterday }
    let!(:issue2) { create :issue, created_at: Time.now.tomorrow }

    subject { Issue.recent }

    it { is_expected.to eq [issue2, issue1] }
  end

  describe '#ensure_manager_on_active' do
    let(:state) { 'pending' }

    subject { build :issue, state: state, manager_id: nil }

    it { is_expected.to be_valid }

    context 'when issue in in progress state' do
      let(:state) { 'in_progress' }

      it { is_expected.not_to be_valid }
    end

    context 'when issue in resolved state' do
      let(:state) { 'resolved' }

      it { is_expected.not_to be_valid }
    end
  end
end
