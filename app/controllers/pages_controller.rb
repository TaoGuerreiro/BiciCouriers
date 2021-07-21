class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :tarifs, :story, :covid]

  def home
    unless user_signed_in?
      cookies[:guest] = SecureRandom.hex(16)
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
