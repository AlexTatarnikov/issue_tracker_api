require 'application_responder'

class ApplicationController < ActionController::API
  include Knock::Authenticable

  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  PER_PAGE = 25.freeze

  self.responder = ApplicationResponder
  respond_to :json

  private

  def page
    params[:page].to_i
  end

  def per_page
    params[:per_page]&.to_i || PER_PAGE
  end

  def not_found
    head :not_found
  end
end
