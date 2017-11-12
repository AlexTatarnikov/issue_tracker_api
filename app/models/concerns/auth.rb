module Auth
  extend ActiveSupport::Concern

  included do
    has_secure_password

    def authentication_token
      @authentication_token ||= Knock::AuthToken.new(payload: { sub: id }).token
    end
  end
end
