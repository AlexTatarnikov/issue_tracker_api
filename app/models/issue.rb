class Issue < ApplicationRecord
  validates :summary, presence: true
end
