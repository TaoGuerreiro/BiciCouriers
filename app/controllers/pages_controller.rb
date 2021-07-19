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
      # binding.pry
      @pickups = @delivery.pickups.first
      @drops = @delivery.drops.first
      @delivery_options = @delivery.delivery_options
    else
      @delivery = Delivery.new
      @pickups = @delivery.pickups.build
      @drops = @delivery.drops.build
      urg = Urgence.find_by(name: 'Dans la journée')
      @delivery.options << urg
      @delivery.user = User.first
      @delivery.draft_id = SecureRandom.hex(16)
      # @delivery.save
      # raise
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
