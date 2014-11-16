class Question < ActiveRecord::Base
  has_many :polls
  belongs_to :room
  has_many :answers

  def set_current!
    self.update_attribute(:current, true)
  end
end