require 'rails_helper'

RSpec.describe Issue, type: :model do
  it { is_expected.to belong_to(:requester).class_name(User) }

  it { is_expected.to validate_presence_of :summary }

  describe '#recent' do
    let!(:issue1) { create :issue, created_at: Time.now.yesterday }
    let!(:issue2) { create :issue, created_at: Time.now.tomorrow }

    subject { Issue.recent }

    it { is_expected.to eq [issue2, issue1] }
  end
end
