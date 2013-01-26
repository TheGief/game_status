class Console < ActiveRecord::Base
  attr_accessible :title, :image_url

  has_and_belongs_to_many :users
  has_many :play_times
  
  validates :title, :image_url, :presence => true
  validates :image_url, format: { with: /.+\.(jpe?g|gif|png)$/ }
end
