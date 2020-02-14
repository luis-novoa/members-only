class User < ApplicationRecord
  before_create :assign_token
  has_secure_password

  def assign_token
    self.remember_digest = User.encrypt(User.new_token)
  end


  class << self
    # Returns a random token.
    def new_token
      SecureRandom.urlsafe_base64
    end

    # Returns an encrypted version of the string passed.
    def encrypt(string)
      Digest::SHA1.hexdigest(string)
    end
  end
end
