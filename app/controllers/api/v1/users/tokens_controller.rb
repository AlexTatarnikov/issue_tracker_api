class Api::V1::Users::TokensController < Knock::AuthTokenController
  private

  def entity_name
    'User'
  end
end
