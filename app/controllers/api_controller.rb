class ApiController < ActionController::API
  # protect_from_forgery with: :null_session

  # before_action :authenticate

  def current_user
    token = bearer_token
    User.find_by(:token => token)
  end

  private
  def authenticate
    render status: 401, json: {:message => 'Not authorized'} unless current_user
  end

  def bearer_token
    pattern = /^Bearer /
    header  = request.headers['Authorization']
    header.gsub(pattern, '') if header && header.match(pattern)
  end
end