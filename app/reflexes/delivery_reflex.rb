class DeliveryReflex < ApplicationReflex
  include Pundit
  delegate :current_user, to: :connection
  before_reflex :skip_authorization, only: [:create]
  
  def adresses_validation
    @delivery = Delivery.new(delivery_params)
    @delivery.save
    # binding.pry    
  end

  def create
    email = params[:delivery][:user][:email]
    # bike = params[:bike].to_i

    urgence = Urgence.find(params[:delivery][:delivery_options_attributes]["0"][:option_id])
    volume = Volume.find(params[:delivery][:delivery_options_attributes]["1"][:option_id])

    # binding.pry

    # if email_check(email)
      @user = User.first
    # else
    #   @user = User.new({
    #     email: email,
    #     password: Devise.friendly_token.first(8)
    #   })
    #   @user.save
    # end

    @delivery = Delivery.new(delivery_params)
    @delivery.user = @user

    # binding.pry 

    if @delivery.save && payement.nil?
      # redirect_to root_path, flash: {alert: 'Delivery bien envoyé à nos bureaux 😎​🚴​'}
      # raise
    else
      # render "pages/home", flash: {error: "Une erreur s'est glissée dans le formulaire !"}
      # raise
    end
    
  end

  private
  def email_check(email)
    User.where(email: email).any?
  end

  def delivery_params
    params.require(:delivery).permit(:details, :bike_id, :distance, :tickets_distance, :tickets_urgence, :tickets_volume, :user,
                                    drops_attributes:[:id, :date, :details, :address, :start_hour, :end_hour, :favorite_address],
                                    pickups_attributes:[:id, :details, :date, :address, :start_hour, :end_hour, :favorite_address],
                                    # user:[:email, :phone],
                                    delivery_options_attributes:[ :option_id, :user_option])
  end
end
