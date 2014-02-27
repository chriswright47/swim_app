class UsersController < ApplicationController
  before_filter :signed_in_user, except: [:new, :create]
  before_filter :correct_user, only: [:edit, :update]
  before_filter :admin_user, only: [:destroy]
  before_filter :teammate_user, only: [:show]


  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    team = Team.find_by_id(params[:team_id])
    @user.team = team
    if @user.save && team
      flash[:success] = 'Account created successfully'
      sign_in(@user)
      redirect_to user_path(@user)
    else
      flash[:error] = 'Account was not created successfully, be sure to select a team'
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    team = Team.find_by_id(params[:team_id])
    @user.update_attributes(user_params)
    if @user.valid?
      @user.team = team if team
      flash[:success] = 'Account updated successfully'
      sign_in(@user)
      redirect_to user_path(@user)
    else
      flash[:error] = 'There were errors in updating, please try again'
      render 'edit'
    end
  end

  def destroy
  end

  private
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
    end

    def teammate_user
      redirect_to root_path unless current_user.team == User.find(params[:id]).team || current_user.admin?
    end

    def correct_user
      redirect_to root_path unless current_user?(User.find(params[:id])) || current_user.admin?
    end
end
