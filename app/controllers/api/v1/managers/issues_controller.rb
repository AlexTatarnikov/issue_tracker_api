class Api::V1::Managers::IssuesController < Api::V1::Managers::BaseController
  def index
    @issues = Issue.recent.page(page).per(per_page)

    respond_with_success(@issues)
  end
end
