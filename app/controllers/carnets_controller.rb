class CarnetsController < ApplicationController


  def index
    @inprogress = policy_scope(Carnet).where('remaining_tickets > ?', 0).order(created_at: :desc)
    @oldone = policy_scope(Carnet).where('remaining_tickets <= ?', 0).order(created_at: :desc)
  end

  def show
    @carnet = Carnet.find(params[:id])
    authorize @carnet
  end

  def new
    @carnet_templates = CarnetTemplate.all
    @carnet = Carnet.new
    authorize @carnet
  end

  def create
    @carnet = Carnet.new(carnet_params)
    @user = current_user
    @carnet.user = current_user
    if @user.pool < 0
      @carnet.remaining_tickets = (@carnet.carnet_template.ticket_nb + @user.pool)
      @user.pool = @user.pool + (@carnet.carnet_template.ticket_nb - @carnet.remaining_tickets)
    else
      @carnet.remaining_tickets = @carnet.carnet_template.ticket_nb
    end

    authorize @carnet
    if @carnet.save
      # raise
      @carnet.save
      @user.save
      redirect_to carnets_path
    else
    # raise
      render :new
    end
  end

  private

  def carnet_params
        params.require(:carnet).permit(:carnet_template_id)
  end

end
