class Api::V1::Users::BaseController < Api::V1::BaseController
  before_action :authenticate_user
end
