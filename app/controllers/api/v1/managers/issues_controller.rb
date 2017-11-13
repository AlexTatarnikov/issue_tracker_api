class Api::V1::Managers::IssuesController < Api::V1::Managers::BaseController
  has_scope :by_state

  def index
    @issues = apply_scopes(Issue).recent.page(page).per(per_page)

    respond_with_success(@issues)
  end
end
