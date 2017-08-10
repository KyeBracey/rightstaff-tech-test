class NursesController < ApplicationController
  def index
    @nurses = Nurse.all
    render json: {data: @nurses}, status: :ok
  end
end
