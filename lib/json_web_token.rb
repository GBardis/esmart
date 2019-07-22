class JsonWebToken
  SECRET_KEY = Rails.application.secrets.secret_key_base. to_s

  def self.encode(payload)
    encoded_token = JWT.encode(payload, SECRET_KEY)
    user_auth_token = AuthToken.find_by(user_id: payload[:user_id])

    if user_auth_token.nil?
      AuthToken.create!(user_id: payload[:user_id], token: encoded_token, expire_time: payload[:exp])
    else
      AuthToken.update(user_id: payload[:user_id], token: encoded_token, expire_time: payload[:exp])
    end
  end

  def self.decode(token)
    decoded = JWT.decode(token, SECRET_KEY)[0]
    HashWithIndifferentAccess.new decoded
  end
end
