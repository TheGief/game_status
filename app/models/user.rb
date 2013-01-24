class User < ActiveRecord::Base
  attr_accessible :username, :email, :phone, :password, :password_confirmation, :remember_me
  devise :database_authenticatable, :registerable, :recoverable,
    :rememberable, :trackable, :validatable, :token_authenticatable,
    :confirmable, :lockable, :timeoutable #, :omniauthable

  before_save { |user| user.email = email.downcase }

  has_and_belongs_to_many :games, :uniq => true
  has_and_belongs_to_many :consoles, :uniq => true
  has_many :play_times
  has_many :friendships
  has_many :friends, 
           :through => :friendships,
           :conditions => "status = 'accepted'", 
           :order => :username

  has_many :requested_friends, 
           :through => :friendships, 
           :source => :friend,
           :conditions => "status = 'requested'", 
           :order => :created_at

  has_many :pending_friends, 
           :through => :friendships, 
           :source => :friend,
           :conditions => "status = 'pending'", 
           :order => :created_at

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  LETTERS_ONLY = /\A[a-zA-Z]+\z/

  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :username, :presence => true, format: { with: LETTERS_ONLY, :message => "is letters only" }, uniqueness: { case_sensitive: false }
  validates :phone, :presence => true, length: { minimum: 10, :message => "is full 10 digit cell number" }
  validates :password, presence: true, length: { minimum: 6 }
end
