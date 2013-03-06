class User < ActiveRecord::Base
  attr_accessible :email, :name, :password
  has_secure_password

  has_many :feeds
  has_many :permissions

  before_save { email.downcase! }
  before_save :create_remember_token

  private

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end

end
