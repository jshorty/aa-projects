class User < ActiveRecord::Base
  validate :username, :password_digest, presence: true
  validate :username, uniqueness: true
  validate :password, length: {minimum: 6, allow_nil: true}
  after_initialize :ensure_session_token

  def ensure_session_token
    self.session_token ||= SecureRandom::urlsafe_base64
  end

  def reset_session_token!
    self.session_token = SecureRandom::urlsafe_base64
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def password
    @password
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def self.find_by_credentials(username, password)
    user = User.find(username: username)
    return nil if user.nil?
    user.is_password?(password) ? user : nil
  end
end
