class User < ApplicationRecord
  before_create :assign_token
  has_secure_password
  has_many :posts
  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.freeze
  validates :name, presence: true, length: { minimum: 4, maximum: 50 }
  validates :email, presence: true, uniqueness: true, length: { maximum: 50 },
                    format: { with: EMAIL_REGEX }
  validates :password, presence: true, length: { minimum: 6, maximum: 20 }

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
