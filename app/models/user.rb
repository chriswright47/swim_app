class User < ActiveRecord::Base
  has_secure_password

  belongs_to :team

  before_save { self.email.downcase! }
  before_save :create_remember_token

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
  validates :email, uniqueness: true
  validates :email, format: { with: /\b[A-Z0-9._%a-z\-]+@(?:[A-Z0-9a-z\-]+\.)+[A-Za-z]{2,6}\z/, message: "not a valid email address"}
  validates :team_id, presence: true

  def full_name
    self.first_name + ' ' + self.last_name
  end

  def assign_to_team(team)
   if self.coach?
      team.coaches << self
    else
      team.athletes << self
    end
  end

  private
  def create_remember_token
    self.remember_token = SecureRandom.urlsafe_base64
  end
end
