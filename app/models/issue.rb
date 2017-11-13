class Issue < ApplicationRecord
  ACTIVE_STATES = %w(in_progress resolved).freeze

  enum state: [:pending, :in_progress, :resolved]

  belongs_to :requester, class_name: 'User'
  belongs_to :manager, optional: true

  validates :summary, presence: true
  validate :ensure_manager_on_active

  scope :recent, -> { order(created_at: :desc) }
  scope :by_state, ->(state) { where(state: state) }
  scope :unassigned, -> { where(manager_id: nil) }

  private

  def ensure_manager_on_active
    if state.in?(ACTIVE_STATES) && manager_id.nil?
      errors.add(:manager_id, I18n.t('errors.messages.blank'))
    end
  end
end
