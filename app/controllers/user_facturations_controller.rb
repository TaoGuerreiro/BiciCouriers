class UserFacturationsController < ApplicationController

  def edit
    @user = current_user
    @user_facturation = @user.user_facturation
    # authorize @user
    authorize @user_facturation
  end

  def update
    @user_facturation = UserFacturation.find(params[:id])

    if @user_facturation.update(user_facturation_params)
      redirect_to root_path
    else
      render :edit
    end
  end

private

  def user_facturation_params
    params.require(:user_facturation).permit()
  end

end
