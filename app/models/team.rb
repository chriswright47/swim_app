class Team < ActiveRecord::Base

  has_many :users

  def athletes
    self.users.where('coach = false')
  end

  def coaches
    self.users.where('coach = true')
  end
end
