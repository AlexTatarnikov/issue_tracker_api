class Manager < ApplicationRecord
  include Auth

  has_many :issues, dependent: :delete_all

  validates :email, uniqueness: true, presence: true
end
