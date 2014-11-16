class Question < ActiveRecord::Base
  has_many :polls
  belongs_to :room
  has_many :answers
end