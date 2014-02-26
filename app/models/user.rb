class User < ActiveRecord::Base
  has_secure_password

  belongs_to :team

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
  validates :email, uniqueness: true
  validates :email, format: { with: /\b[A-Z0-9._%a-z\-]+@(?:[A-Z0-9a-z\-]+\.)+[A-Za-z]{2,6}\z/, message: "not a valid email address"}

  def full_name
    self.first_name + ' ' + self.last_name
  end
end
