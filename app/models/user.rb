class User < ActiveRecord::Base
  has_secure_password

  attr_accessible :username, :email, :phone, :password

  has_and_belongs_to_many :games, :uniq => true
  has_and_belongs_to_many :consoles, :uniq => true

  # unique email address
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }

  LETTERS_ONLY = /\A[a-zA-Z]+\z/
  validates :username, :presence => true, format: { with: LETTERS_ONLY, :message => "is letters only" }, uniqueness: { case_sensitive: false }

  validates :phone, :presence => true, length: { minimum: 10, :message => "is full 10 digit cell number" }
  validates :password, presence: true, length: { minimum: 6 }

  before_save { |user| user.email = email.downcase }

end
