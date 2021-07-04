
class DeliveriesController < ApplicationController
  before_action :authenticate_user!, except: [:create, :new, :distance, :ticket_urgence, :ticket_distance, :ticket_volume, :init_urgences]
  before_action :skip_authorization, only: [:create, :new, :distance, :ticket_urgence, :ticket_distance, :ticket_volume, :init_urgences]

  def show
    @delivery = Delivery.find(params[:id])
    authorize @delivery
  end

  def ticket_volume
    data = JSON.parse(volume_params.to_json)

    # binding.pry


    id = Volume.find(data["id"].to_i)

    render json: id.ticket
  end

  def distance
    addresses = JSON.parse(distance_params.to_json)

    pickup = addresses["puAddressName"].to_s
    drop = addresses["drAddressName"].to_s

    distance = dist(pickup, drop)

    render json: distance
  end


   def init_urgences
    city = City.find_by(name: "Nantes")
    now = Time.now.utc + 3600
    day_start = Time.new(now.year, now.mon, now.day, city.start_hour.slice(0,2), city.start_hour.slice(3,4), 00)
    day_end =   Time.new(now.year, now.mon, now.day, city.end_hour.slice(0,2),   city.end_hour.slice(3,4),   00)
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
          urgence_0_day: day_to_today(urgence_0_end),
          urgence_1_day: day_to_today(urgence_1_end),
          urgence_2_day: day_to_today(urgence_2_end),
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

  def ticket_urgence
    # binding.pry

    data = JSON.parse(urgence_params.to_json)
    id = data["id"]
    urgence = Urgence.find(id.to_i)

    pu_start = Time.new()
    pu_end =   Time.new + urgence.range
    dr_start = Time.new()
    dr_end =   Time.new + urgence.range

    # pu_start = Time.new(data["stDate"].slice(6..9), data["stDate"].slice(3..4), data["stDate"].slice(0..1), data["puStart"].slice(0,2),  data["puStart"].slice(3,4), 00)
    # pu_end =   Time.new(data["ndDate"].slice(6..9), data["ndDate"].slice(3..4), data["ndDate"].slice(0..1), data["puEnd"].slice(0,2),    data["puEnd"].slice(3,4), 00)
    # dr_start = Time.new(data["stDate"].slice(6..9), data["stDate"].slice(3..4), data["stDate"].slice(0..1), data["drStart"].slice(0,2),  data["drStart"].slice(3,4), 00)
    # dr_end =   Time.new(data["ndDate"].slice(6..9), data["ndDate"].slice(3..4), data["ndDate"].slice(0..1), data["drEnd"].slice(0,2),    data["drEnd"].slice(3,4), 00)
    # now = Time.now

    tickets = urge(pu_start.round, pu_end.round, dr_start.round, dr_end.round)
    puts "*"*90
    puts tickets

    respond_to do |format|
         # format.html
         format.json { render json: { tickets_urgence: tickets, pus: pu_start.strftime("%H:%M"), pue: pu_end.strftime("%H:%M"), drs: dr_start.strftime("%H:%M"), dre: dr_end.strftime("%H:%M") } }
    end


  end

  def ticket_distance

    response = JSON.parse(tickets_params.to_json)
    distance = response['distanceM']

    tickets = tick(distance)

    render json: tickets
  end

  def index

    @pending = policy_scope(Delivery).where(status: 'pending').order(created_at: :desc)
    @inprogress = policy_scope(Delivery).where(status: 'inprogress')
    @accepted = policy_scope(Delivery).where(status: 'accepted')
    @done = policy_scope(Delivery).where(status: 'done')

    @deliveries = policy_scope(Delivery).order(created_at: :desc)
  end

  def new
    @favorite_addresses = policy_scope(FavoriteAddress).order(title: :asc)
    @user = User.new
    @availible_options = Option.joins(:user_options).where('user_id = ?', current_user.id)

    @delivery = Delivery.new
    @drop = @delivery.drops.build
    @pickup = @delivery.pickups.build
    @tickets_book = current_user.tickets_books.joins(:order_item).where('remaining_tickets > ? AND order_items.state = ?', 0, 'paid').first


    # @drop = Drop.geocoded
    # @drop_marker = [lat: @drop.first.latitude, lng: @drop.first.longitude]

    authorize @drop
    authorize @pickup
  end

  def create

    if user_signed_in? # USER EN LIGNE OLD VERSION
      @user = current_user
      @delivery = Delivery.new(delivery_params)
      @delivery.bike_id = Bike.first.id if @delivery.bike_id.nil?
      @delivery.user = @user
      # authorize @delivery
      all_user_tickets_books = @user.tickets_books.joins(:order_item).where('remaining_tickets > ? AND order_items.state = ?', 0, 'paid').order(created_at: :asc)
      @cart = @user.order_items.last

      raise

      if (all_user_tickets_books.last.present? && @delivery.ticket_nb > all_user_tickets_books.last.tickets_book_template.ticket_nb)
        redirect_to new_delivery_path, flash: {alert: 'Bien trop de tickets pour une si grosse delivery ! :o'}
      else

        if user_have_a_tickets_book?(@user)
          create_order_item unless user_have_a_cart?(@cart)
          if user_have_enought_tickets?(@delivery, all_user_tickets_books)
            if only_one_tickets_book?(all_user_tickets_books)
              @tickets_book = all_user_tickets_books.last
              add_delivery_to_tickets_book(@tickets_book, @delivery)
              @tickets_book.save
              # raise
              save_data(@delivery, deliveries_path)
            else
              add_delivery_on_both_tickets_books_and_save(all_user_tickets_books, @delivery)
              save_data(@delivery, deliveries_path)
            end
          else
            if tickets_book_renewal?(@user)
              create_new_tickets_book(@user, all_user_tickets_books.first)
              if only_one_tickets_book?(all_user_tickets_books)
                @tickets_book = all_user_tickets_books.last
                add_delivery_to_tickets_book(@tickets_book, @delivery)
                @tickets_book.save
                save_data(@delivery, deliveries_path)
              else
                both_tickets_books = @user.tickets_books.joins(:order_item).where('remaining_tickets > ? AND order_items.state = ?', 0, 'paid').order(created_at: :asc)
                add_delivery_on_both_tickets_books_and_save(both_tickets_books, @delivery)
                save_data(@delivery, deliveries_path)
              end
            else
              redirect_to new_tickets_book_path, flash: {alert: 'Plus assez de tickets, veuillez renouveller votre tickets_book !'}

            end
          end
        else
          create_order_item unless user_have_a_cart?(@cart)
          add_delivery_to_cart(@delivery, @cart)
          @cart.save
          save_data_tickets_book_less(@delivery)
        end
      end
    else # USER HORS LIGNE V1.0
      # @city = City.find_by(name: "Nantes")
      # @availible_urgence_options = Urgence.includes(:city_options)
      # @availible_volume_options = Volume.includes(:city_options)
      # binding.pry
      email = params[:delivery][:user][:email]
      bike = params[:bike].to_i

      urgence = Urgence.find(params[:delivery][:delivery_options_attributes]["0"][:option_id])
      volume = Volume.find(params[:delivery][:delivery_options_attributes]["1"][:option_id])
  
      if email_check(email)
        @user = User.find_by(email: email)
      else
        @user = User.create({
          email: email,
          password: Devise.friendly_token.first(8)
        })
      end

      @delivery = Delivery.new(delivery_params)
      @delivery.user = @user


      # if bike == 0
      #   @delivery.bike_id = Bike.first.id
      # else
      #   @delivery.bike_id = Bike.last.id
      # end
      # @delivery.bike_id = Bike.first.id if bike == 0

      # puAddress = params[:delivery][:pickups_attributes]["0"][:address]
      # drAddress = params[:delivery][:drops_attributes]  ["0"][:address]

      # puSt = params[:delivery][:pickups_attributes] ["0"][:start_hour]
      # puNd = params[:delivery][:pickups_attributes] ["0"][:end_hour]
      # drSt = params[:delivery][:drops_attributes]   ["0"][:start_hour]
      # drNd = params[:delivery][:drops_attributes]   ["0"][:end_hour]

      # stDate = params[:delivery][:pickups_attributes]["0"][:date]
      # ndDate = params[:delivery][:drops_attributes]  ["0"][:date]

      # pu_start = Time.new(stDate.slice(6..9), stDate.slice(3..4), stDate.slice(0..1), puSt.slice(0,2),  puSt.slice(3,4), 00)
      # pu_end =   Time.new(ndDate.slice(6..9), ndDate.slice(3..4), ndDate.slice(0..1), puNd.slice(0,2),  puNd.slice(3,4), 00)
      # dr_start = Time.new(stDate.slice(6..9), stDate.slice(3..4), stDate.slice(0..1), drSt.slice(0,2),  drSt.slice(3,4), 00)
      # dr_end =   Time.new(ndDate.slice(6..9), ndDate.slice(3..4), ndDate.slice(0..1), drNd.slice(0,2),  drNd.slice(3,4), 00)

      # @delivery.tickets_urgence = urge(pu_start, pu_end, dr_start, dr_end)
      # @delivery.tickets_volume = params[:bike]
      # @delivery.distance = dist(puAddress, drAddress)
      # @delivery.tickets_distance = tick(@delivery.distance)
      # @delivery.ticket_nb = @delivery.tickets_distance.to_i + @delivery.tickets_volume.to_i + @delivery.tickets_urgence.to_i
      # @delivery.price_cents = price(@delivery.ticket_nb)
      payement = params[:stripe]
      if @delivery.save && (payement == "on") #STRIPE PAYEMENT
        create_order_item
        @delivery.update(order_item: @cart)
        # raise
        order  = Order.create!(order_item: @cart, amount: @delivery.price, state: 'pending', user: @user)
        session = Stripe::Checkout::Session.create(
          payment_method_types: ['card'],
          line_items: [{
            name: 'Nouvelle livraison',
            # images: [order_item.photo_url], implémenter la carte google ?
            amount: (@delivery.price_cents * 1.2).ceil.to_i,
            currency: 'eur',
            quantity: 1
          }],
          customer_email: @user.email,
          success_url: "#{root_url}orders/success?session_id={CHECKOUT_SESSION_ID}",
          cancel_url: "#{root_url}orders/cancel?session_id={CHECKOUT_SESSION_ID}",
        )
        order.update(checkout_session_id: session.id)

        @checkout_id = order.checkout_session_id

        respond_to do |format|
             # format.html
             format.json { render json: { checkout_id: @checkout_id } }
        end

      elsif @delivery.save && payement.nil?
        redirect_to root_path, flash: {alert: 'Delivery bien envoyé à nos bureaux 😎​🚴​'}
        # raise
      else
        render "pages/home", flash: {error: "Une erreur s'est glissée dans le formulaire !"}
        # raise
      end
    end
  end

  def destroy
    @order_item = OrderItem.last
    @delivery = Delivery.find(params[:id])
    remove_delivery_from_cart(@delivery, @order_item)
    @order_item.save
    @delivery.destroy
    redirect_to order_item_path(@order_item.id)
    authorize @delivery
  end



private

  # def guest_delivery_params
  #   params.require(:delivery).permit(:details, :bike_id, drops_attributes:[:id, :date, :details, :address, :start_hour, :end_hour, :favorite_address], pickups_attributes:[:id, :details, :date, :address, :start_hour, :end_hour, :favorite_address], user:[:email])
  # end

  def delivery_params
    params.require(:delivery).permit(:details, :bike_id, :distance, :tickets_distance, :tickets_urgence, :tickets_volume, :user,
                                    drops_attributes:[:id, :date, :details, :address, :start_hour, :end_hour, :favorite_address],
                                    pickups_attributes:[:id, :details, :date, :address, :start_hour, :end_hour, :favorite_address],
                                    delivery_options_attributes:[ :option_id, :user_option])
  end

  def user_have_a_tickets_book?(user)
    user.tickets_books.present?
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

  def add_delivery_to_cart(delivery, cart)
    delivery.order_item = cart
    cart.price_cents += (500 * delivery.ticket_nb)
  end

  def remove_delivery_from_cart(delivery, cart)
    delivery.order_item = cart
    cart.price_cents -= (500 * delivery.ticket_nb)
  end

  def add_tickets_book_to_cart(tickets_book, cart)
    tickets_book.order_item = cart
    cart.price_cents += (tickets_book.tickets_book_template.price_cents)
  end


  def save_data(data, path)
    if data.save
      redirect_to path
    else
       render :new
    end
  end

  def save_data_tickets_book_less(data)
    if data.save
      redirect_to order_item_path(current_user.order_items.last)
    else
       render :new
    end
  end

  def create_order_item
    @cart = OrderItem.create(user: @user)
    return @cart
  end

  def user_have_enought_tickets?(delivery, tickets_books)
    delivery.ticket_nb <= tickets_books.sum(:remaining_tickets)
  end

  def only_one_tickets_book?(tickets_books)
    true if tickets_books.count == 1
  end

  def add_delivery_to_tickets_book(tickets_book, delivery)
    tickets_book.remaining_tickets -= delivery.ticket_nb
    delivery.tickets_book = tickets_book
  end

  def add_delivery_on_both_tickets_books_and_save(tickets_books, delivery)
    tickets_to_report = delivery.ticket_nb - tickets_books[0].remaining_tickets
    if tickets_to_report <= 0
      tickets_books[0].remaining_tickets -= delivery.ticket_nb
      delivery.tickets_book = tickets_books[0]
    else
      tickets_books[0].remaining_tickets = 0
      tickets_books[1].remaining_tickets -= tickets_to_report
      delivery.tickets_book = tickets_books[0]
    end
      tickets_books.each { |tickets_book| tickets_book.save}
  end

  def tickets_book_renewal?(user)
    user.tickets_book_renewal
  end

  def create_new_tickets_book(user, last_tickets_book)
    @new_tickets_book = TicketsBook.create(
      {
      tickets_book_template_id: last_tickets_book.tickets_book_template.id,
      user_id: user.id,
      remaining_tickets: last_tickets_book.tickets_book_template.ticket_nb
      }
    )
  end

  #______________________V2______________________

  def dist(pu, dr)
    begin
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
    rescue NoMethodError
        return 0
    end
  end

  def tick(dist)
    if is_user_and_have_tickets_book?
      tickets = (dist/1000.000/(current_user.tickets_books.last.tickets_book_template.distance_max)).ceil
    else
      tickets = (dist/1000.000/3.500).ceil
    end
    return tickets
  end

  def price(ticket_nb)
    if is_user_and_have_tickets_book?
      unit_price = current_user.tickets_books.last.tickets_book_template.price_cents
    else
      unit_price = 500
    end
    return unit_price * ticket_nb
  end

  def urge(pus, pue, drs, dre)
    city = City.find_by(name: "Nantes")
    day_start = Time.new(Time.now.year, Time.now.mon, Time.now.day, city.start_hour.slice(0,2), city.start_hour.slice(3,4), 00)
    day_end =   Time.new(Time.now.year, Time.now.mon, Time.now.day, city.end_hour.slice(0,2),   city.end_hour.slice(3,4), 00)
    puts pus
    puts pue
    puts drs
    puts dre
    now = Time.now
    p pue  - pus

    ticket = 0

    case
      when (pue - pus) <= city.urgence_one_size
        ticket += 2
      when (pue - pus) <= city.urgence_two_size
        ticket += 1
    end

    return ticket
  end

  def is_user_and_have_tickets_book?
    (user_signed_in? && user_have_a_tickets_book?(current_user))
  end

  def email_check(email)
    User.where(email: email).any?
  end

  def urgences_calculation(number)

    city = City.find_by(name: "Nantes")
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

  def day_to_today(date)
    if date.day == Time.now.day
      return "Aujourd'hui"
    elsif date.day == Time.now.day + 1
      return "Demain"
    else
      return l(date, format: '%A')
    end
  end

  #______________________PARAMS AJAX______________________
  def distance_params
    params.require(:addresses).permit(:puAddressName, :drAddressName)
  end

  def urgence_params
    params.require(:urgence).permit(:id, :puStart, :puEnd, :drStart, :drEnd, :stDate, :ndDate)
  end

  def tickets_params
    params.require(:distance).permit(:distanceM)
  end

  def volume_params
    params.require(:volume).permit(:id)
  end

  def mail_params
    params.require(:request).permit(:mail)
  end

end
