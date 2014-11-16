class Room < ActiveRecord::Base
  belongs_to :user
  has_many :users

  before_save :validate_url

  def validate_url
  	self.url = URI.encode(name.gsub( /\s+/, '-' ))
  end

end