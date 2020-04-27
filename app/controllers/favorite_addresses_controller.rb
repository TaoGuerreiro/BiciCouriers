class FavoriteAddressesController < ApplicationController

  def index
    @favorite_addresses = policy_scope(FavoriteAddress).order(title: :asc)
    @favorite_address = FavoriteAddress.new
    # authorize @favorite_address
  end

  def new
    @favorite_address = FavoriteAddress.new
    authorize @favorite_address
  end
  def destroy
    @favorite_address = FavoriteAddress.find(params[:id])
    @favorite_address.destroy
    redirect_to favorite_addresses_path
    authorize @favorite_address

  end

  def show
    @favorite_address = FavoriteAddress.find(params[:id])
    authorize @favorite_address
  end

  def create
    @favorite_address = FavoriteAddress.new(favorite_address_params)
    @favorite_address.user = current_user

    if @favorite_address.save
      redirect_to favorite_addresses_path
    else
      render "favorite_addresses/index"
    end
    authorize @favorite_address
  end

private

  def favorite_address_params
    params.require(:favorite_address).permit(:id, :details, :address, :start_hour, :end_hour, :title)
  end
end
