class Api::V1::Managers::TokensController < Knock::AuthTokenController
  private

  def entity_name
    'Manager'
  end
end
