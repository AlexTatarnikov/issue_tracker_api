require 'rails_helper'

RSpec.describe Manager, type: :model do
  it { is_expected.to have_secure_password }
  it { is_expected.to validate_presence_of :email }

  describe 'uniqueness validation' do
    before { create :manager }
    it { is_expected.to validate_uniqueness_of :email }
  end
end
