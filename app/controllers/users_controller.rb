class UsersController < ApplicationController
  def show
    @user = User.find(current_user.id)

    authorize @user

  end

end
