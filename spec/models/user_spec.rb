require 'rails_helper'

RSpec.describe User, type: :model do
  it { is_expected.to have_many(:issues).dependent(:delete_all) }

  it { is_expected.to have_secure_password }
  it { is_expected.to validate_presence_of :email }

  describe 'uniqueness validation' do
    before { create :user }
    it { is_expected.to validate_uniqueness_of :email }
  end
end
