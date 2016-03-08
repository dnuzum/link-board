class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.authenticate(user_params[:email], 
      user_params[:password])
    if user
      #login
      session[:user_id] = user.id
      flash[:success] = 'You have logged in!'
      redirect_to secret_path
    else
      #fail
      flash[:danger] = 'Email and/or password are incorrect.'
      redirect_to login_path
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "You have been logged out."
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end 
end
