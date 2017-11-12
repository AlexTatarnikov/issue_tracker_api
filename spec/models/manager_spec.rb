require 'rails_helper'

RSpec.describe Manager, type: :model do
  it { is_expected.to have_secure_password }

  describe 'uniqueness validation' do
    before { create :manager }
    it { is_expected.to validate_uniqueness_of :email }
  end
end
