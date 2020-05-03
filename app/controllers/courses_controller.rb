class CoursesController < ApplicationController

  def show
    @course = Course.find(params[:id])
    authorize @course
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
    @carnet = current_user.carnets.where('remaining_tickets > ?', 0).first


    # @drop = Drop.geocoded
    # @drop_marker = [lat: @drop.first.latitude, lng: @drop.first.longitude]

    authorize @drop
    authorize @pickup
  end

  def create
    @user = current_user

    @course = Course.new(course_params)
    @course.bike_id = Bike.first.id if @course.bike_id.nil?
    @course.user = @user
    authorize @course

    # parcour sans carnet ______________________________________________________
    if @user.carnets == []
      if @course.save
        redirect_to courses_path
      else
        render :new
        raise
      end

    # parcour avec carnet ______________________________________________________
    else
      if is_enought_ticket?   # assez de ticket
        @course.carnet = @carnet
        if @course.save
          add_course_to_carnet(@carnet, @course, @user)
          @carnet.save
          @user.save
          redirect_to courses_path
        else
          render :new
        end
      elsif carnet_renewal? # pas assez, mais renouvellement auto
        create_next_carnet
        @ticket_to_actual = @carnet.remaining_tickets
        @course.ticket_overflow = @ticket_to_actual
        @carnet.remaining_tickets = 0
        @ticket_to_next = (@course.ticket_nb - @ticket_to_actual)
        @next_carnet.course_overflow = @ticket_to_next

        @next_carnet.remaining_tickets = (@next_carnet.remaining_tickets - @ticket_to_next)
        @next_carnet.save

        @course.carnet = @carnet
        if @course.save
          add_course_to_carnet(@carnet, @course, @user)
          @carnet.save
          @next_carnet.save
          @user.save
          redirect_to courses_path
        else
          render :new
        end
      else # pas assez, et pas renouvellement auto
        @course.carnet = @carnet
        if @course.save
          add_course_to_carnet(@carnet, @course, @user)
          @carnet.save
          @user.save
          redirect_to courses_path
        else
          render :new
        end
      end
    end
  end

private

  def course_params
    params.require(:course).permit(:ticket_nb, :tickets_volume, :tickets_urgence, :tickets_distance, :distance, :details, :status, :price, :urgence, :bike_id, drops_attributes:[:id, :date, :details, :address, :start_hour, :end_hour, :favorite_address], pickups_attributes:[:id, :details, :date, :address, :start_hour, :end_hour, :favorite_address])
  end

  def add_course_to_carnet(carnet, course, user)
    if carnet.remaining_tickets <= 0
       user.pool = user.pool + carnet.remaining_tickets
       carnet.remaining_tickets = 0
      flash[:notice] = "Attention, vous n'avez plus de ticket dans votre carnet !"
    else
      carnet.remaining_tickets = (carnet.remaining_tickets - course.ticket_nb)
      if carnet.remaining_tickets <= 0
       user.pool = user.pool + carnet.remaining_tickets
       carnet.remaining_tickets = 0
      flash[:notice] = "Attention, vous n'avez plus de ticket dans votre carnet !"
      end
    end
  end

  def is_enought_ticket?
    @ticket_nb = @course.ticket_nb
    @carnet = @user.carnets.where('remaining_tickets > ?', 0).first
    @ticket_left = @carnet.remaining_tickets

    @ticket_nb > @ticket_left ? false : true
  end

  def save_the_course

  end

  def carnet_renewal?
    @user.carnet_renewal
  end

  def create_next_carnet
    @next_carnet = Carnet.create(
      {
      carnet_template_id: @carnet.carnet_template.id,
      user_id: @user.id,
      remaining_tickets: @carnet.carnet_template.ticket_nb
      }
    )
  end












end
