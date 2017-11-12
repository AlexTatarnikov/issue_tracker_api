require 'rails_helper'

RSpec.describe User, type: :model do
  it { is_expected.to have_secure_password }

  describe 'uniqueness validation' do
    before { create :user }
    it { is_expected.to validate_uniqueness_of :email }
  end
end
