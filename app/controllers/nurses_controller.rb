class NursesController < ApplicationController
  def index
    @nurses = Nurse.all
    render json: {data: @nurses}, status: :ok
  end

  def show
    @nurse = Nurse.find(params[:id])
    render json: {data: @nurse}, status: :ok
  end
end
