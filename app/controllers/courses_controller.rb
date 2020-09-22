
class CoursesController < ApplicationController
  before_action :authenticate_user!, except: [:create, :new, :distance, :urgence, :tickets_nb, :volume, :checkout_id, :init_urgences]
  before_action :skip_authorization, only: [:create, :new, :distance, :urgence, :tickets_nb, :volume, :checkout_id, :init_urgences]

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

  def init_urgences
    city = City.find_by(city_name: "Nantes")
    day_start = Time.new(Time.now.year, Time.now.mon, Time.now.day, city.start_hour.slice(0,2), city.start_hour.slice(3,4), 00)
    day_end =   Time.new(Time.now.year, Time.now.mon, Time.now.day, city.end_hour.slice(0,2),   city.end_hour.slice(3,4),   00)
    now = Time.now
    case
      when now < day_start #AVANT L'HEURE
        urgence_0_start = day_start
        urgence_1_start = day_start
        urgence_2_start = day_start

        urgence_0_end = day_end
        urgence_1_end = day_start + city.urgence_one_size
        urgence_2_end = day_start + city.urgence_two_size
      when now > day_end #APRES L'HEURE L'HEURE
        urgence_0_start = day_start + 86400
        urgence_1_start = day_start + 86400
        urgence_2_start = day_start + 86400

        urgence_0_end = day_end + 86400
        urgence_1_end = day_start + 86400 + city.urgence_one_size
        urgence_2_end = day_start + 86400 + city.urgence_two_size
      when (now + city.urgence_one_size) > day_end #APRES ''18H15''
        urgence_0_start = day_start + 86400
        urgence_1_start = day_start + 86400
        urgence_2_start = day_start + 86400

        urgence_0_end = day_end + 86400 #Demain avant 19H
        urgence_1_end = day_start + 86400 + city.urgence_one_size
        urgence_2_end = day_start + 86400 + city.urgence_two_size
      when (now + city.urgence_two_size) > day_end #APRES ''16H''
        urgence_0_start = now
        urgence_1_start = now
        urgence_2_start = now

        urgence_0_end = day_start + 86400 + city.urgence_two_size #Demain avant 12H
        urgence_1_end = now + city.urgence_one_size
        urgence_2_end = day_end
      when now.between?(day_start, day_end)
        urgence_0_start = now
        urgence_1_start = now
        urgence_2_start = now

        urgence_0_end = day_end
        urgence_1_end = now + city.urgence_one_size
        urgence_2_end = now + city.urgence_two_size
    end

    respond_to do |format|
      format.json { render json: {
          urgence_0_day: l(urgence_0_end, format: '%A'),
          urgence_1_day: l(urgence_1_end, format: '%A'),
          urgence_2_day: l(urgence_2_end, format: '%A'),
          urgence_0_start_hour: l(urgence_0_start, format: '%R'),
          urgence_1_start_hour: l(urgence_1_start, format: '%R'),
          urgence_2_start_hour: l(urgence_2_start, format: '%R'),
          urgence_0_end_hour:   l(urgence_0_end, format: '%R'),
          urgence_1_end_hour:   l(urgence_1_end, format: '%R'),
          urgence_2_end_hour:   l(urgence_2_end, format: '%R'),
          urgence_0_start_date: l(urgence_0_start, format: '%d/%m/%Y'),
          urgence_1_start_date: l(urgence_1_start, format: '%d/%m/%Y'),
          urgence_2_start_date: l(urgence_2_start, format: '%d/%m/%Y'),
          urgence_0_end_date:   l(urgence_0_end, format: '%d/%m/%Y'),
          urgence_1_end_date:   l(urgence_1_end, format: '%d/%m/%Y'),
          urgence_2_end_date:   l(urgence_2_end, format: '%d/%m/%Y'),
        }
      }
    end
  end

  def urgence

    data = JSON.parse(urgence_params.to_json)
    puts "*" * 123
    puts data["stDate"]

    pu_start = Time.new(Time.now.year, Time.now.mon, data["stDate"], data["puStart"].slice(0,2),  data["puStart"].slice(3,4), 00)
    pu_end =   Time.new(Time.now.year, Time.now.mon, data["ndDate"], data["puEnd"].slice(0,2),    data["puEnd"].slice(3,4), 00)
    dr_start = Time.new(Time.now.year, Time.now.mon, data["stDate"], data["drStart"].slice(0,2),  data["drStart"].slice(3,4), 00)
    dr_end =   Time.new(Time.now.year, Time.now.mon, data["ndDate"], data["drEnd"].slice(0,2),    data["drEnd"].slice(3,4), 00)
    now = Time.now

    tickets = urge(pu_start, pu_end, dr_start, dr_end)
    puts "*"*90
    puts tickets

    respond_to do |format|
         # format.html
         format.json { render json: { tickets_urgence: tickets } }
    end


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
      email = params[:course][:user][:email]
      if email_check(email)
        @user = User.find_by_email(email)
      else
        @user = User.create({
          email: email,
          password: Devise.friendly_token.first(8)
        })
      end
      # if user already rec
      @course = Course.new(course_params)
      @course.bike_id = Bike.first.id if @course.bike_id.nil?
      @course.user = @user
      puAddress = params[:course][:pickups_attributes]["0"][:address]
      drAddress = params[:course][:drops_attributes]  ["0"][:address]

      puSt = params[:course][:pickups_attributes] ["0"][:start_hour]
      puNd = params[:course][:pickups_attributes] ["0"][:end_hour]
      drSt = params[:course][:drops_attributes]   ["0"][:start_hour]
      drNd = params[:course][:drops_attributes]   ["0"][:end_hour]

      puSt = Time.new(Time.now.year, Time.now.mon, Time.now.day, puSt.slice(0,2), puSt.slice(3,4), 00)
      puNd = Time.new(Time.now.year, Time.now.mon, Time.now.day, puNd.slice(0,2), puNd.slice(3,4), 00)
      drSt = Time.new(Time.now.year, Time.now.mon, Time.now.day, drSt.slice(0,2), drSt.slice(3,4), 00)
      drNd = Time.new(Time.now.year, Time.now.mon, Time.now.day, drNd.slice(0,2), drNd.slice(3,4), 00)

      @course.tickets_urgence = urge(puSt, puNd, drSt, drNd)
      @course.distance = dist(puAddress, drAddress)
      @course.tickets_distance = tick(@course.distance)
      @course.ticket_nb = @course.tickets_distance.to_i + params[:tickets_volume].to_i + @course.tickets_urgence.to_i
      @course.price_cents = price(@course.ticket_nb)
      payement = params[:stripe]
      if @course.save && (payement == "on") #STRIPE PAYEMENT
        create_shopping_cart
        order  = Order.create!(shopping_cart: @cart, amount: @course.price, state: 'pending', user: @user)
        session = Stripe::Checkout::Session.create(
          payment_method_types: ['card'],
          line_items: [{
            name: 'Nouvelle livraison',
            # images: [shopping_cart.photo_url], implémenter la carte google ?
            amount: (@course.price_cents * 1.2).ceil.to_i,
            currency: 'eur',
            quantity: 1
          }],
          success_url: order_url(order),
          cancel_url: order_url(order)
        )
        order.update(checkout_session_id: session.id)

        @checkout_id = order.checkout_session_id

        respond_to do |format|
             # format.html
             format.json { render json: { checkout_id: @checkout_id } }
        end

      elsif @course.save && payement.nil?
        redirect_to root_path, flash: {alert: 'Course bien envoyé à nos bureaux'}
      else
        render "pages/home", flash: {error: "Une erreur s'est glissée dans le formulaire !"}
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
    city = City.find_by(city_name: "Nantes")
    day_start = Time.new(Time.now.year, Time.now.mon, Time.now.day, city.start_hour.slice(0,2), city.start_hour.slice(3,4), 00)

    day_end =   Time.new(Time.now.year, Time.now.mon, Time.now.day, city.end_hour.slice(0,2),   city.end_hour.slice(3,4), 00)
    puts pus
    puts pue
    puts drs
    puts dre
    now = Time.now

    ticket = 0

    case
      when (pue - pus) <= city.urgence_one_size
        ticket += 2
      when (pue - pus) <= city.urgence_two_size
        ticket += 1
    end

    return ticket
  end

  def is_user_and_have_carnet?
    (user_signed_in? && user_have_a_carnet?(current_user))
  end

  def email_check(email)
    User.where(email: email).any?
  end

  def urgences_calculation(number)

    city = City.find_by(city_name: "Nantes")
    day_start = Time.new(Time.now.year, Time.now.mon, Time.now.day, city.start_hour.slice(0,2), city.start_hour.slice(3,4), 00)
    day_end =   Time.new(Time.now.year, Time.now.mon, Time.now.day, city.end_hour.slice(0,2),   city.end_hour.slice(3,4),   00)
    now = Time.now
    case
      when now < day_start #AVANT L'HEURE
        drop_end = day_end if number == 0
        drop_end = day_start + city.urgence_one_size if number == 1
        drop_end = day_start + city.urgence_two_size if number == 2
      when now > day_end #APRES L'HEURE L'HEURE
        drop_end = day_end + 86400 if number == 0
        drop_end = day_start + 86400 + city.urgence_one_size if number == 1
        drop_end = day_start + 86400 + city.urgence_two_size if number == 2
      when (now + city.urgence_one_size) > day_end #APRES ''18H''
        drop_end = day_end + 86400 if number == 0
        drop_end = day_start + 86400 + city.urgence_one_size if number == 1
        drop_end = day_start + 86400 + city.urgence_two_size if number == 2
      when (now + city.urgence_two_size) > day_end #APRES ''16H''
        drop_end = day_start + 86400 + city.urgence_two_size if number == 0
        drop_end = now + city.urgence_one_size if number == 1
        drop_end = day_end if number == 2
      when now.between?(day_start, day_end)
        drop_end = day_end if number == 0
        drop_end = now + city.urgence_one_size if number == 1
        drop_end = now + city.urgence_two_size if number == 2
    end
      return drop_end
  end


  #______________________PARAMS AJAX______________________
  def distance_params
    params.require(:addresses).permit(:puAddressName, :drAddressName)
  end

  def urgence_params
    params.require(:urgence).permit(:puStart, :puEnd, :drStart, :drEnd, :stDate, :ndDate)
  end

  def tickets_params
    params.require(:distance).permit(:distanceM)
  end

  def volume_params
    params.require(:volume).permit(:size)
  end

  def mail_params
    params.require(:request).permit(:mail)
  end

end




