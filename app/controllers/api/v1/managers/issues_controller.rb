class Api::V1::Managers::IssuesController < Api::V1::Managers::BaseController
  has_scope :by_state

  def index
    @issues = apply_scopes(Issue).recent.page(page).per(per_page)

    respond_with_success(@issues)
  end

  def update
    @issue = current_manager.issues.find(params[:id])
    @issue.update(issue_params)

    respond_with_success(@issue)
  end

  private

  def issue_params
    params.require(:issue).permit(:state)
  end
end
