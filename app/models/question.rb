class Question < ActiveRecord::Base
  belongs_to :room
  has_many :answers
  has_many :polls
end