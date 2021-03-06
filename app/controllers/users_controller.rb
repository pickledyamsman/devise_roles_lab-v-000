class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    if !current_user.admin? || !(current_user = @user)
      flash[:error] = "Access denied."
      redirect_to root_path
    end
  end

  def destroy
    @user = User.find(params[:id])
    if current_user.admin?
      @user.destroy
      redirect_to root_path, :notice => "User deleted"
    else
      redirect_to root_path, :notice => "Access denied."
    end
  end
end