module Api
  class BaseController < ActionController::API
    include ActionController::MimeResponds

    respond_to :json

    before_action :authorize

    private

    def authorize
      header = request.headers['Authorization']
      header = header.split(' ').last if header
      begin
        @decoded = JsonWebToken.decode(header)
        @current_user = User.find(@decoded[:user_id])
      rescue ActiveRecord::RecordNotFound => e
        render json: { errors: e.message }, status: :unauthorized
      rescue JWT::DecodeError => e
        render json: { errors: e.message }, status: :unauthorized
      end
      render json: { errors: 'Access has been revoked' }, status: :unauthorized unless @current_user.nil? || @current_user.auth_token.active
    end
  end
end
