module RequestHelper
  def sign_in(user=nil)
    user = user || create(:user)

    request.headers['Authorization'] = user.authentication_token
  end
end

