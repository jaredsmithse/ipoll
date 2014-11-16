class Answer < ActiveRecord::Base
  has_many :polls
  belongs_to :question
  has_many :users, through: :polls

end