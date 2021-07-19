class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :tarifs, :story, :covid]

  def home
    @user = User.new
    @city = City.find_by(name: "Nantes")
    unless user_signed_in?
      # request.env['warden'].set_user(1)
      cookies[:guest] = SecureRandom.hex(16)
    end


    if @delivery
      @pickups = @delivery.pickups.first
      @drops = @delivery.drops.first
      @delivery_options = @delivery.delivery_options
    else
      @delivery = Delivery.new
      @pickups = @delivery.pickups.build
      @drops = @delivery.drops.build
      @delivery_options = @delivery.delivery_options.build
    end

    # @drop ||= Drop.new


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
