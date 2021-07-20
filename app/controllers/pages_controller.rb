class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :tarifs, :story, :covid]

  def home
    @user = User.new
    @city = City.find_by(name: "Nantes")
    unless user_signed_in?
      # request.env['warden'].set_user(1)
      cookies[:guest] = SecureRandom.hex(16)
    end

    p @delivery
    if @delivery
      # binding.pry
      @urgence = @delivery.delivery_options.first
      @volume = @delivery.delivery_options.last
      # @delivery_options = @delivery.delivery_options
      @pickups = @delivery.pickups.first
      @drops = @delivery.drops.first
    else
      @delivery = Delivery.new
      @pickups = @delivery.pickups.build
      @drops = @delivery.drops.build

      urgence_optn = Urgence.find_by(name: 'Dans la journée')
      @urgence = @delivery.delivery_options.new(option: urgence_optn )

      volume_optn = Volume.find_by(name: '- de 6 kilos')
      @volume = @delivery.delivery_options.new(option: volume_optn )

      @delivery.user = User.first
      @delivery.draft_id = SecureRandom.hex(16)
      @delivery.status = 'draft'
      # @delivery.save
      raise
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
