class UsersController < ApplicationController
  def show
    @user = User.find(current_user.id)
    @user_facturation = @user.user_facturation
    authorize @user
    authorize @user_facturation
  end

end
