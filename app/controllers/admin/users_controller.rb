class Admin::UsersController < Admin::ApplicationController
  before_action :set_user, only: [:show]

  def index
    @users = User.order(:email)
  end

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "User has been created."
      redirect_to [:admin, @user]
    else
      flash.now[:alert] = "User has not been created."
      render "new"
    end
  end

  private
    def user_params
      params.require(:user).permit(:email, :password)
    end

    def set_user
      @user = User.find(params[:id])
    end
end
