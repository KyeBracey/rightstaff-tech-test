class NursesController < ApplicationController
  def index
    @nurses = Nurse.all
    render json: {data: @nurses}, status: :ok
  end

  def show
    render json: {}, status: :ok
  end
end
