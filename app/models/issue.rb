class Issue < ApplicationRecord

  belongs_to :requester, class_name: 'User'
  belongs_to :manager, optional: true

  validates :summary, presence: true

  enum state: [:pending, :in_progress, :resolved]

  scope :recent, -> { order(created_at: :desc) }
  scope :by_state, ->(state) { where(state: state) }
end
