class TeamsController < ApplicationController
  before_filter :signed_in?
  before_filter :admin_user, except: [:show, :edit, :update]
  before_filter :coach_user, only: [:edit, :update]
  before_filter :correct_team_user, only: [:show, :edit, :update]

  def index
  end

  def show
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
    def admin_user
      redirect_to root_path unless current_user.admin?
    end

    def coach_user
      redirect_to root_path unless current_user.coach?
    end

    def correct_team_user
      redirect_to root_path unless current_user.team == Team.find_by_id(params[:id])
    end

end
