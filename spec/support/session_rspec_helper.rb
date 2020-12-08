module RSpecSessionHelper
  def log_in user
    @request.env["devise.mapping"] = Devise.mappings[:user]
    user.confirm
    sign_in user
  end
end
