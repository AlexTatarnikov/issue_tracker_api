class User < ApplicationRecord
  include Auth

  validates :email, uniqueness: true, presence: true
end
