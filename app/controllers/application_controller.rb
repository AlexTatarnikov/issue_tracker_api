require 'application_responder'

class ApplicationController < ActionController::API
  include Knock::Authenticable

  PER_PAGE = 25

  self.responder = ApplicationResponder
  respond_to :json

  protected

  def page
    params[:page].to_i
  end

  def per_page
    params[:per_page]&.to_i || PER_PAGE
  end
end
