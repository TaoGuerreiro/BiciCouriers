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
    @favorite_address = FavoriteAddress.new
    @favorite_addresses = policy_scope(FavoriteAddress).order(title: :asc)

    @course = Course.new
    drop = @course.drops.build
    pickup = @course.pickups.build
    authorize drop
    authorize pickup
    @carnet = current_user.carnets.where('remaining_tickets > ?', 0).first


    # @drop = Drop.geocoded
    # @drop_marker = [lat: @drop.first.latitude, lng: @drop.first.longitude]

  end

  def create
    @course = Course.new(course_params)
    @course.bike_id = Bike.first.id if @course.bike_id.nil?
    @user = current_user
    @carnet = @user.carnets.where('remaining_tickets > ?', 0).first
    @course.user = @user
    @course.carnet = @carnet
    authorize @course
    if @course.save
      add_course_to_carnet(@carnet, @course, @user)
      @carnet.save
      @user.save
      redirect_to courses_path
    else
      render :new
    end
  end

private

  def course_params
        params.require(:course).permit(:ticket_nb, :tickets_volume, :tickets_urgence, :tickets_distance, :distance, :details, :status, :price, :urgence, :bike_id, drops_attributes:[:id, :date, :details, :address, :start_hour, :end_hour], pickups_attributes:[:id, :details, :date, :address, :start_hour, :end_hour])
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
end
