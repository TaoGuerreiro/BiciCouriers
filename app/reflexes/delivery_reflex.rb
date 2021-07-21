class DeliveryReflex < ApplicationReflex
  include Pundit
  include ApplicationHelper
  delegate :current_user, to: :connection
  before_reflex :build, except: [:new]
  after_reflex :morph_form, except: [:create]

  def new
    @delivery = Delivery.new
    @city = City.first

    @pickups = @delivery.pickups.build
    @drops = @delivery.drops.build

    @delivery.urgence = Urgence.find_by(name: 'Dans la journée')
    @delivery.volume = Volume.find_by(name: '- de 6 kilos')
  end

  def distance
    @delivery.user = User.first
    begin
      url = 'https://maps.googleapis.com/maps/api/directions/json?'
      query = {
        origin: @delivery.pickups.first.address,
        destination: @delivery.drops.first.address,
        mode: "walking",
        key: ENV['GOOGLE_API_KEY']
      }
      distance = JSON.parse(HTTParty.get(
        url,
        query: query
      ).body)
      @delivery.distance = (distance['routes'][0]['legs'][0]['distance']['value'])
      @delivery.tickets_distance = ((@delivery.distance / 1000) / 3.5).ceil
    rescue NoMethodError
     end
    end

  def urgence

  end

  def volume
  end

  def create
    current_user == String ? @user = current_user : @user = User.first
    @delivery.user = @user
    if @delivery.save
      # redirect_to '/', flash: {alert: 'OKKKKK'}
    else
      morph "#delivery_form", render(DeliveryFormComponent.new(delivery: @delivery, city: @city))
      # throw :abort
    end
  end

  private

  def build
    @delivery = Delivery.new(delivery_params)
    @city = City.first
  end

  def morph_form
    morph "#delivery_form", render(DeliveryFormComponent.new(delivery: @delivery, city: @city))
  end

  def delivery_params
    params.require(:delivery).permit(:details, :distance, :tickets_distance, :user, :draft_id,
                                    :urgence_id, :volume_id, :phone, :email,
                                    drops_attributes:[:id, :date, :details, :address, :start_hour, :end_hour, :favorite_address],
                                    pickups_attributes:[:id, :details, :date, :address, :start_hour, :end_hour, :favorite_address],
                                    delivery_options_attributes:[ :option_id, :user_option])
  end
end
