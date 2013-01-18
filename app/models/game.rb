class Game < ActiveRecord::Base
  attr_accessible :title, :image_url
  validates :title, :image_url, :presence => true
  validates :image_url, format: { with: /.+\.(jpe?g|gif|png)$/ }
end
