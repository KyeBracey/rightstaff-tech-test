class NursesController < ApplicationController
  def index
    @nurses = Nurse.all
    render json: {data: @nurses}, status: :ok
  end

  def show
    @nurse = Nurse.find(params[:id])
    render json: {data: @nurse}, status: :ok
  end

  def create
    role = Role.find(params[:role])
    nurse = role.nurses.build(nurse_params)
    nurse.save
    render json: {}, status: :ok
  end

  def update
    render json: {}, status: :ok
  end
end

def nurse_params
  params.permit(:email, :first_name, :last_name, :phone_number, :verified, :sign_in_count)
end
