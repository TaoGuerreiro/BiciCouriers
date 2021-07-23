class DropsController < ApplicationController
  def new
    # @drop = Drop.new
  end

  def create
    # @drop = Drop.new(drop_params)
    # if @drop.save
    #   raise
    #   redirect_to courses_path
    # else
    #   render :new
    # end
  end
private

  # def drop_params
  #       params.require(:drop).permit(:id, :date, :details, :address, :start_hour, :end_hour)
  # end
end
