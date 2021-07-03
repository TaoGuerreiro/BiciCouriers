class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :tarifs, :story, :covid]

  def home
    # @user = User.new
    unless user_signed_in?
      # request.env['warden'].set_user(1)
      cookies[:guest] = SecureRandom.hex(16)
    end
    @delivery ||= Delivery.new
    @city = City.find_by(name: "Nantes")
    @drop ||= @delivery.drops.build
    @pickup ||= @delivery.pickups.build
    @delivery_option ||= @delivery.delivery_options.build
    @urgence ||= Urgence.find_by(name: 'Dans la journée')
    @volume ||= Volume.find_by(name: '- de 6 kilos')
    # @volume_option = @delivery.delivery_options.build
    # DeliveryOption.new(delivery: @delivery, option)

  if current_user
    @availible_options = Option.includes(:user_options).where(user_options: { user: current_user })
  else
    @availible_urgence_options = Urgence.includes(:city_options)
    @availible_volume_options = Volume.includes(:city_options)
  end


  end

  def story
  end

  def tarifs
  end

  def covid
    @user = User.new
    @course = Course.new
    # @order = Order.last
    # @city = City.find_by(city_name: "Nantes")
    @drop = @course.drops.build
    @pickup = @course.pickups.build
  end

end
