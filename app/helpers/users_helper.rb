module UsersHelper
  def possible_team_options
    Team.pluck(:name, :id)
  end

end
