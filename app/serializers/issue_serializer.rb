class IssueSerializer < ApplicationSerializer
  attributes :id, :type, :summary, :description, :state
end
