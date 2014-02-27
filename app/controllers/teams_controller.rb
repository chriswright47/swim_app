class TeamsController < ApplicationController
  before_filter :signed_in_user
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

end
