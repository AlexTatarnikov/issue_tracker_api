class Api::V1::Managers::AssignsController < Api::V1::Managers::BaseController

  def create
    @issue = Issue.unassigned.find(params[:id])
    @issue.update(manager_id: current_manager.id)

    respond_with_success(@issue)
  end

  def destroy
    @issue = current_manager.issues.find(params[:id])

    if @issue.update(manager_id: nil)
      head :no_content
    else
      respond_with_error(@issue)
    end
  end
end
