
class CoursesController < ApplicationController
  before_action :authenticate_user!, except: [:create, :new, :distance, :urgence, :tickets_nb, :volume]
  before_action :skip_authorization, only: [:create, :new, :distance, :urgence, :tickets_nb, :volume]

  def show
    @course = Course.find(params[:id])
    authorize @course
  end

  def volume
    volume = JSON.parse(volume_params.to_json)

    bike_id = volume["size"].to_i

    render json: bike_id
  end

  def distance
    addresses = JSON.parse(distance_params.to_json)

    pickup = addresses["puAddressName"].to_s
    drop = addresses["drAddressName"].to_s

    distance = dist(pickup, drop)

    render json: distance
  end

  def urgence
    urgence = JSON.parse(urgence_params.to_json)

    puStart = Time.new(Time.now.year, Time.now.mon, Time.now.day, urgence["puStart"].slice(0,2), urgence["puStart"].slice(3,4), 00)
    puEnd = Time.new(Time.now.year, Time.now.mon, Time.now.day, urgence["puEnd"].slice(0,2), urgence["puEnd"].slice(3,4), 00)
    drStart = Time.new(Time.now.year, Time.now.mon, Time.now.day, urgence["drStart"].slice(0,2), urgence["drStart"].slice(3,4), 00)
    drEnd = Time.new(Time.now.year, Time.now.mon, Time.now.day, urgence["drEnd"].slice(0,2), urgence["drEnd"].slice(3,4), 00)

    tickets_urgence = urge(puStart, puEnd, drStart, drEnd)

    render json: tickets_urgence

  end

  def tickets_nb

    response = JSON.parse(tickets_params.to_json)
    distance = response['distanceM']

    tickets = tick(distance)

    render json: tickets
  end

  def index

    @pending = policy_scope(Course).where(status: 'pending').order(created_at: :desc)
    @inprogress = policy_scope(Course).where(status: 'inprogress')
    @accepted = policy_scope(Course).where(status: 'accepted')
    @done = policy_scope(Course).where(status: 'done')

    @courses = policy_scope(Course).order(created_at: :desc)
  end

  def new
    @favorite_addresses = policy_scope(FavoriteAddress).order(title: :asc)
    @user = User.new

    @course = Course.new
    @drop = @course.drops.build
    @pickup = @course.pickups.build
    @carnet = current_user.carnets.joins(:shopping_cart).where('remaining_tickets > ? AND shopping_carts.state = ?', 0, 'paid').first


    # @drop = Drop.geocoded
    # @drop_marker = [lat: @drop.first.latitude, lng: @drop.first.longitude]

    authorize @drop
    authorize @pickup
  end

  def create

    if user_signed_in? # USER EN LIGNE OLD VERSION
      @user = current_user
      @course = Course.new(course_params)
      @course.bike_id = Bike.first.id if @course.bike_id.nil?
      @course.user = @user
      # authorize @course
      all_user_carnets = @user.carnets.joins(:shopping_cart).where('remaining_tickets > ? AND shopping_carts.state = ?', 0, 'paid').order(created_at: :asc)
      @cart = @user.shopping_carts.last


      if (all_user_carnets.last.present? && @course.ticket_nb > all_user_carnets.last.carnet_template.ticket_nb)
        redirect_to new_course_path, flash: {alert: 'Bien trop de tickets pour une si grosse course ! :o'}
      else

        if user_have_a_carnet?(@user)
          create_shopping_cart unless user_have_a_cart?(@cart)
          if user_have_enought_tickets?(@course, all_user_carnets)
            if only_one_carnet?(all_user_carnets)
              @carnet = all_user_carnets.last
              add_course_to_carnet(@carnet, @course)
              @carnet.save
              # raise
              save_data(@course, courses_path)
            else
              add_course_on_both_carnets_and_save(all_user_carnets, @course)
              save_data(@course, courses_path)
            end
          else
            if carnet_renewal?(@user)
              create_new_carnet(@user, all_user_carnets.first)
              if only_one_carnet?(all_user_carnets)
                @carnet = all_user_carnets.last
                add_course_to_carnet(@carnet, @course)
                @carnet.save
                save_data(@course, courses_path)
              else
                both_carnets = @user.carnets.joins(:shopping_cart).where('remaining_tickets > ? AND shopping_carts.state = ?', 0, 'paid').order(created_at: :asc)
                add_course_on_both_carnets_and_save(both_carnets, @course)
                save_data(@course, courses_path)
              end
            else
              redirect_to new_carnet_path, flash: {alert: 'Plus assez de tickets, veuillez renouveller votre carnet !'}

            end
          end
        else
          create_shopping_cart unless user_have_a_cart?(@cart)
          add_course_to_cart(@course, @cart)
          @cart.save
          save_data_carnet_less(@course)
        end
      end
    else # USER HORS LIGNE V1.0
      # raise
      #parcours de facturation hors-ligne
      email = params[:course][:user][:email]
      raise if email_check(email)


      # if user already rec
      @course = Course.new(course_params)
      @course.bike_id = Bike.first.id if @course.bike_id.nil?
      @course.user = @user
      puAddress = params[:course][:pickups_attributes]["0"][:address]
      drAddress = params[:course][:drops_attributes]["0"][:address]

      # puSt = params[:course][:pickups_attributes]["0"][:start_hour]
      # puNd = params[:course][:pickups_attributes]["0"][:end_hour]
      # drSt = params[:course][:drops_attributes]["0"][:start_hour]
      # drNd = params[:course][:drops_attributes]["0"][:end_hour]

      puSt = Time.new(Time.now.year, Time.now.mon, Time.now.day, params[:course][:pickups_attributes]["0"][:start_hour].slice(0,2), params[:course][:pickups_attributes]["0"][:start_hour].slice(3,4), 00)
      puNd = Time.new(Time.now.year, Time.now.mon, Time.now.day, params[:course][:pickups_attributes]["0"][:end_hour].slice(0,2),   params[:course][:pickups_attributes]["0"][:end_hour].slice(3,4), 00)
      drSt = Time.new(Time.now.year, Time.now.mon, Time.now.day, params[:course][:drops_attributes]["0"][:start_hour].slice(0,2),   params[:course][:drops_attributes]["0"][:start_hour].slice(3,4), 00)
      drNd = Time.new(Time.now.year, Time.now.mon, Time.now.day, params[:course][:drops_attributes]["0"][:end_hour].slice(0,2),     params[:course][:drops_attributes]["0"][:end_hour].slice(3,4), 00)

      @course.tickets_urgence = urge(puSt, puNd, drSt, drNd)
      @course.distance = dist(puAddress, drAddress)
      @course.tickets_distance = tick(@course.distance)
      @course.ticket_nb = @course.tickets_distance.to_i + params[:tickets_volume].to_i + @course.tickets_urgence.to_i
      @course.price_cents = price(@course.ticket_nb)

      if @course.save
        raise
        redirect_to root_path, flash: {alert: 'Well !'}
      else
        render "pages/home", flash: {error: 'Il doit y avoir un soucis dans le formulaire !'}
      end
    end
  end

  def destroy
    @shopping_cart = ShoppingCart.last
    @course = Course.find(params[:id])
    remove_course_from_cart(@course, @shopping_cart)
    @shopping_cart.save
    @course.destroy
    redirect_to shopping_cart_path(@shopping_cart.id)
    authorize @course
  end



private

  # def guest_course_params
  #   params.require(:course).permit(:details, :bike_id, drops_attributes:[:id, :date, :details, :address, :start_hour, :end_hour, :favorite_address], pickups_attributes:[:id, :details, :date, :address, :start_hour, :end_hour, :favorite_address], user:[:email])
  # end

  def course_params
    params.require(:course).permit(:details, :bike_id, drops_attributes:[:id, :date, :details, :address, :start_hour, :end_hour, :favorite_address], pickups_attributes:[:id, :details, :date, :address, :start_hour, :end_hour, :favorite_address])
  end

  def user_have_a_carnet?(user)
    user.carnets.present?
  end

  def user_have_a_cart?(cart)
    if cart.blank?
      return false
    elsif cart.state == 'pending'
      return true
    else
      return false
    end
  end

  def add_course_to_cart(course, cart)
    course.shopping_cart = cart
    cart.price_cents += (583 * course.ticket_nb)
  end

  def remove_course_from_cart(course, cart)
    course.shopping_cart = cart
    cart.price_cents -= (583 * course.ticket_nb)
  end

  def add_carnet_to_cart(carnet, cart)
    carnet.shopping_cart = cart
    cart.price_cents += (carnet.carnet_template.price_cents)
  end


  def save_data(data, path)
    if data.save
      redirect_to path
    else
       render :new
    end
  end

  def save_data_carnet_less(data)
    if data.save
      redirect_to shopping_cart_path(current_user.shopping_carts.last)
    else
       render :new
    end
  end

  def create_shopping_cart
    @cart = ShoppingCart.create(user: @user)
  end

  def user_have_enought_tickets?(course, carnets)
    course.ticket_nb <= carnets.sum(:remaining_tickets)
  end

  def only_one_carnet?(carnets)
    true if carnets.count == 1
  end

  def add_course_to_carnet(carnet, course)
    carnet.remaining_tickets -= course.ticket_nb
    course.carnet = carnet
  end

  def add_course_on_both_carnets_and_save(carnets, course)
    tickets_to_report = course.ticket_nb - carnets[0].remaining_tickets
    if tickets_to_report <= 0
      carnets[0].remaining_tickets -= course.ticket_nb
      course.carnet = carnets[0]
    else
      carnets[0].remaining_tickets = 0
      carnets[1].remaining_tickets -= tickets_to_report
      course.carnet = carnets[0]
    end
      carnets.each { |carnet| carnet.save}
  end

  def carnet_renewal?(user)
    user.carnet_renewal
  end

  def create_new_carnet(user, last_carnet)
    @new_carnet = Carnet.create(
      {
      carnet_template_id: last_carnet.carnet_template.id,
      user_id: user.id,
      remaining_tickets: last_carnet.carnet_template.ticket_nb
      }
    )
  end





  #______________________V2______________________

  def dist(pu, dr)

    url = 'https://maps.googleapis.com/maps/api/directions/json?'
    query = {
      origin: pu,
      destination: dr,
      key: ENV['GOOGLE_API_KEY']
    }

    distance = JSON.parse(HTTParty.get(
      url,
      query: query
    ).body)

    return (distance['routes'][0]['legs'][0]['distance']['value'])
  end

  def tick(dist)
    if is_user_and_have_carnet?
      tickets = (dist/1000.000/(current_user.carnets.last.carnet_template.distance_max)).ceil
    else
      tickets = (dist/1000.000/3.500).ceil
    end
    return tickets
  end

  def price(ticket_nb)
    if is_user_and_have_carnet?
      unit_price = current_user.carnets.last.carnet_template.price_cents
    else
      unit_price = 583
    end
    return unit_price * ticket_nb
  end

  def urge(pus, pue, drs, dre)
    #coder toute la logique d'urgence, en fonction des data utilisateur && carnets
    ticket = 0
    pickup_slot = pue - pus
    drop_slot = dre - drs

    case pickup_slot
      when 0..(3600)
        ticket = 2 + ticket
      when (3601)..(4 * 3600)
        ticket = 1 + ticket
      when (14401)..(11 * 3600)
        ticket = 0 + ticket
      else
    end

    case drop_slot
      when 0..(3600)
        ticket = 2 + ticket
      when (3601)..(4 * 3600)
        ticket = 1 + ticket
      when (14401)..(11 * 3600)
        ticket = 0 + ticket
      else
    end
    return ticket
  end

  def is_user_and_have_carnet?
    (user_signed_in? && user_have_a_carnet?(current_user))
  end

  #______________________PARAMS AJAX______________________
  def distance_params
    params.require(:addresses).permit(:puAddressName, :drAddressName)
  end

  def urgence_params
    params.require(:urgence).permit(:puStart, :puEnd, :drStart, :drEnd)
  end

  def tickets_params
    params.require(:distance).permit(:distanceM)
  end

  def volume_params
    params.require(:volume).permit(:size)
  end

  def email_check(email)
    User.where(email: email).any?
  end

end




