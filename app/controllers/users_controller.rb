class UsersController < ApplicationController

  def show
    @user = User.find(current_user.id)

    authorize @user
  end

  def new
    @user = User.new
  end

private

  def params_user
    params.require(:user).permit(:email, :encrypted_password)
  end
end
