module Authentication
  extend ActiveSupport::Concern

  included do
    before_action :authenticate_request
  end

  private

  def authenticate_request
    token = request.headers['Authorization']&.split(' ')&.last
    decoded_token = JwtService.decode(token)

    if decoded_token
      @current_user = User.find(decoded_token[:user_id])
    else
      render json: { status: "error", message: "Unauthorized" }, status: :unauthorized
    end
  end
end