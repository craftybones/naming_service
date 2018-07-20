class ApiController < ActionController::API

  before_action :authenticate

  private

  def authenticate
    render status: 401, json: {:message => 'Not authorized'} unless current_user
  end

  def current_user
    token = bearer_token
    User.find_by(:token => token) if token
  end

  def bearer_token
    pattern = /^Bearer /
    header  = request.headers['Authorization']
    header.gsub(pattern, '') if header && header.match(pattern)
  end
end