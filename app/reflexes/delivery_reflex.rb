class DeliveryReflex < ApplicationReflex
  include Pundit
  delegate :current_user, to: :connection
  before_reflex :skip_authorization, only: [:create_pickup, :create_drop]

  # def create_pickup
  #   delivery = Delivery.find(element.dataset.delivery_id)
  #   @pickup = delivery.pickups.create!(delivery_params)
  #   morph :nothing
  # end

  # def create_drop
  #   # binding.pry
  #   delivery = Delivery.find(element.dataset.delivery_id)
  #   @drop = delivery.drops.first.update!({
  #     address: params[:delivery][:drop][:address],
  #     start_hour: params[:delivery][:drop][:start_hour],
  #     end_hour: params[:delivery][:drop][:end_hour]
  #   })
  #   morph :nothing
  # end

  def distance
    if @delivery = Delivery.find_by(draft_id: params[:delivery][:draft_id])
      @delivery = Delivery.find_by(draft_id: params[:delivery][:draft_id])
    else
      @delivery = Delivery.new(delivery_params)
    end
    @delivery.user = User.first
    # binding.pry
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
     @delivery.save
     morph "#total", render(TotalComponent.new(delivery: @delivery))
  end

  def urgence
    if @delivery = Delivery.find_by(draft_id: params[:delivery][:draft_id])
      @delivery = Delivery.find_by(draft_id: params[:delivery][:draft_id])
    else
      @delivery = Delivery.new(delivery_params)
    end
    # binding.pry
    morph "#total", render(TotalComponent.new(delivery: @delivery))
  end

  def create
    # binding.pry
    @delivery = Delivery.new(delivery_params)

    @delivery.save
  end

  private

  def delivery_params
    params.require(:delivery).permit(:details, :distance, :tickets_distance, :tickets_urgence, :tickets_volume, :user, :draft_id,
                                    drops_attributes:[:id, :date, :details, :address, :start_hour, :end_hour, :favorite_address],
                                    pickups_attributes:[:id, :details, :date, :address, :start_hour, :end_hour, :favorite_address],
                                    delivery_options_attributes:[ :option_id, :user_option])
  end

  def drop_params
    params.require(:drop).permit(:address, :start_hour, :end_hour)
  end
end
