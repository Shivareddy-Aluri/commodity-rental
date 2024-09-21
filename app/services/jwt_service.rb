class JwtService
    HMAC_SECRET = Rails.application.credentials.secret_key_base

    def self.decode(token)
        body = JWT.decode(token, HMAC_SECRET)[0]
        HashWithIndifferentAccess.new(body)
    rescue JWT::DecodeError
        nil
    end
end
  