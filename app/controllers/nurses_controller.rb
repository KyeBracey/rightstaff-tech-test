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
    nurse = Nurse.find_by_id(params[:id])
    return render json: {message: "Could not find nurse with id: #{params[:id]}"}, status: :bad_request unless nurse
    if nurse.update_attributes(nurse_params)
      render json: {message: "Updated details for nurse with id: #{nurse.id}"}, status: :ok
    else
      render json: {message: 'Edit unsuccessful'}, status: :bad_request
    end
  end
end

def nurse_params
  params.permit(:email, :first_name, :last_name, :phone_number, :verified, :sign_in_count)
end
