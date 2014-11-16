class Room < ActiveRecord::Base
  belongs_to :user
  has_many :users
  has_many :questions

  before_save :validate_url

  def current_question
    questions.detect(&:current)
  end

  def validate_url
  	self.url = URI.encode(name.gsub( /\s+/, '-' ))
  end

end