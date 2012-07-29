class User < ActiveRecord::Base
  has_secure_password

  attr_accessible :email, :password

  # unique email address
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
  					uniqueness: { case_sensitive: false }

  # 
  validates :password, presence: true, length: { minimum: 6 }

  before_save { |user| user.email = email.downcase }

end
