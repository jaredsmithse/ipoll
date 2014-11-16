class User < ActiveRecord::Base
  enum role: [:pollee, :owner, :admin]
  after_initialize :set_default_role, :if => :new_record?
  
  has_one :room
  has_many :polls
  has_many :answers, through: :polls

  def set_default_role
    self.role ||= :pollee
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
end
