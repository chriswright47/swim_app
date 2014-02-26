class UsersController < ApplicationController
  before_filter :signed_in?, except: [:new, :create]
  before_filter :correct_user, only: [:edit, :update]
  before_filter :admin_user, only: [:destroy]

  def show
  end

  def new
    @user = User.new
    @teams = Team.select(:id, :name).map {|t| [t.name, t.id] }
  end

  def create
    @user = User.new(user_params)
    @user.team = Team.find_by_id(params[:team_id])
    if @user.save
      flash[:success] = 'Account created successfully'
      sign_in(@user)
      redirect_to user_path(@user)
    else
      flash[:error] = 'Account was not created successfully'
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

    def correct_user
      user = User.find_by_id(params[:id])
      redirect_to root_path unless current_user?(user)
    end

    def admin_user
      redirect_to root_path unless current_user.admin?
    end

end
