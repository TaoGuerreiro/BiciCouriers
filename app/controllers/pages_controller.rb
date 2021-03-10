class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :tarifs, :story, :covid]

  def home
    # @user = User.new
    unless user_signed_in?
      # request.env['warden'].set_user(1)
      cookies[:guest] = SecureRandom.hex(16)
    end
    @course ||= Course.new
    # @order = Order.last
    @city = City.find_by(name: "Nantes")
    @drop = @course.drops.build
    @pickup = @course.pickups.build
    @course_option = @course.course_options.build

if current_user
    @availible_urgences = Urgence.joins(:user_options).where('user_options.user_id = ?', current_user.id)
    @availible_volumes = Volume.joins(:user_options).where('user_options.user_id = ?', current_user.id)
    @availible_supplements = Option.joins(:user_options).where('user_options.user_id = ?', current_user.id)
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
