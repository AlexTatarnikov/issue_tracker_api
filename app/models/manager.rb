class Manager < ApplicationRecord
  include Auth

  validates :email, uniqueness: true
end
