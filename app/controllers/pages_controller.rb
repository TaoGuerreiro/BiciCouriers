class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :tarifs, :story, :covid]

  def home
    @user = User.new
    @city = City.find_by(name: "Nantes")
    unless user_signed_in?
      # request.env['warden'].set_user(1)
      cookies[:guest] = SecureRandom.hex(16)
    end

    # p @delivery
    if @delivery
      # binding.pry
      @urgence = @delivery.urgence
      @volume = @delivery.volume
      # @delivery_options = @delivery.delivery_options
      @pickups = @delivery.pickups
      @drops = @delivery.drops
    else
      @delivery = Delivery.new

      @pickups = @delivery.pickups.build
      @drops = @delivery.drops.build

      urgence_optn = Urgence.find_by(name: 'Dans la journée')
      @delivery.urgence = urgence_optn

      volume_optn = Volume.find_by(name: '- de 6 kilos')
      @delivery.volume = volume_optn

      # @delivery.user = User.first
      # @delivery.draft_id = SecureRandom.hex(16)
      # @delivery.status = 'draft'
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
