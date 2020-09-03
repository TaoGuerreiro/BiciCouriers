class CoursesController < ApplicationController

  def show
    @course = Course.find(params[:id])
    authorize @course
  end

  def distance
    raise
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


    if user_signed_in?
      @user = current_user
      @course = Course.new(course_params)
      @course.bike_id = Bike.first.id if @course.bike_id.nil?
      @course.user = @user
      authorize @course
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
              save_data(@course)
            else
              add_course_on_both_carnets_and_save(all_user_carnets, @course)
              save_data(@course)
            end
          else
            if carnet_renewal?(@user)
              create_new_carnet(@user, all_user_carnets.first)
              if only_one_carnet?(all_user_carnets)
                @carnet = all_user_carnets.last
                add_course_to_carnet(@carnet, @course)
                @carnet.save
                save_data(@course)
              else
                both_carnets = @user.carnets.joins(:shopping_cart).where('remaining_tickets > ? AND shopping_carts.state = ?', 0, 'paid').order(created_at: :asc)
                add_course_on_both_carnets_and_save(both_carnets, @course)
                save_data(@course)
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
    else
      raise
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

  def course_params
    params.require(:course).permit(:ticket_nb, :tickets_volume, :tickets_urgence, :tickets_distance, :distance, :details, :status, :price, :urgence, :bike_id, drops_attributes:[:id, :date, :details, :address, :start_hour, :end_hour, :favorite_address], pickups_attributes:[:id, :details, :date, :address, :start_hour, :end_hour, :favorite_address])
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


  def save_data(data)
    if data.save
      redirect_to courses_path
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

end
