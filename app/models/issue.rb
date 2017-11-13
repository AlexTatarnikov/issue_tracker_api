class Issue < ApplicationRecord

  belongs_to :requester, class_name: 'User'

  validates :summary, presence: true

  scope :recent, -> { order(created_at: :desc) }
end