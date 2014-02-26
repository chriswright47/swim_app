class StaticPagesController < ApplicationController

  def home
    if signed_in?
      redirect_to team_path(current_user.team)
    end
  end

  def help
  end

  def about
  end

  def contact
  end

end
