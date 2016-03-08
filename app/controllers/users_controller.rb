class UsersController < ApplicationController
  before_filter :is_authenticated?,
    :only => :show

  def new
    @user = User.new
  end

  def create
    user = User.create(user_params)
    flash[:success] = 'User created'
    session[:user_id] = user.id
    redirect_to root_path
  end

  def show
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
