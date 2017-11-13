class User < ApplicationRecord
  include Auth

  has_many :issues, foreign_key: :requester_id, dependent: :delete_all

  validates :email, uniqueness: true, presence: true
end
