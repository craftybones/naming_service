class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def api_token
    @token = current_user.token
  end

  def regenerate_token
    redirect_to api_token_path if current_user.regenerate_token
  end

  def create
    user = User.new(user_params)
    if user.save
      redirect_to users_path
    else
      render 'new'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :password, :password_confirmation)
  end

end