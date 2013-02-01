class Console < ActiveRecord::Base
  attr_accessible :title, :image_url

  has_many :consoles_users
  has_many :users, through: :consoles_users
  has_many :play_times
  
  validates :title, :image_url, :presence => true
  validates :image_url, format: { with: /.+\.(jpe?g|gif|png)$/ }
end
