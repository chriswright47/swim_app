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
    if @user.save && team
      team.users << @user
      flash[:success] = 'Account created successfully'
      sign_in(@user)
      redirect_to user_path(@user)
    else
      flash[:error] = 'Account was not created successfully, be sure to select a team'
      render 'new'
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
    end

    def teammate_user
      redirect_to root_path unless current_user.team == User.find(params[:id]).team
    end

end
