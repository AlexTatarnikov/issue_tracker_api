class User < ApplicationRecord
  has_secure_password

  validates :email, uniqueness: true

  def authentication_token
    @authentication_token ||= Knock::AuthToken.new(payload: { sub: id }).token
  end
end
