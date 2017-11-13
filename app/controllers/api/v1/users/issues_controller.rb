class Api::V1::Users::IssuesController < Api::V1::Users::BaseController

  def index
    @issues = current_user.issues.recent.page(page).per(per_page)

    respond_with_success(@issues)
  end

  def show
    @issues = current_user.issues.find(params[:id])

    respond_with_success(@issues)
  end

  def create
    @issue = current_user.issues.create(issue_params)

    if @issue.persisted?
      respond_with_success(@issue, status: 201)
    else
      respond_with_error(@issue)
    end
  end

  def update
    @issue = current_user.issues.find(params[:id])

    if @issue.update(issue_params)
      respond_with_success(@issue)
    else
      respond_with_error(@issue)
    end
  end

  def destroy
    current_user.issues.find(params[:id]).destroy

    head :no_content
  end

  private

  def issue_params
    params.require(:issue).permit(:summary, :description)
  end
end
