class NursesController < ApplicationController
  def index
    @nurses = Nurse.all
    render json: {data: @nurses}, status: :ok
  end

  def show
    if @nurse = Nurse.find_by_id(params[:id])
      render json: {data: @nurse}, status: :ok
    else
      render json: { message: "Could not find nurse with id: #{params[:id]}" }, status: :bad_request
    end
  end

  def create
    role = Role.find(params[:role])
    nurse = role.nurses.build(nurse_params)
    if nurse.save
      render json: {}, status: :ok
    else
      render json: {message: 'Invalid details - record not created'}, status: :bad_request
    end
    p nurse
    p nurse.valid?
  end

  def update
    nurse = Nurse.find_by_id(params[:id])
    p nurse
    return render json: {message: "Could not find nurse with id: #{params[:id]}"}, status: :bad_request unless nurse
    nurse.update_attributes(nurse_update_params)
    if nurse.save
      render json: {message: "Updated details for nurse with id: #{nurse.id}"}, status: :ok
    else
      render json: {message: 'Edit unsuccessful'}, status: :bad_request
    end
  end

  def destroy
    if nurse = Nurse.find_by_id(params[:id])
      nurse.destroy
      render json: {message: "Deleted records for nurse with id: #{params[:id]}"}, status: :ok
    else
      render json: {message: "Could not find nurse with id: #{params[:id]}"}, status: :bad_request
    end
  end
end

def nurse_params
  params.permit(:email, :first_name, :last_name, :phone_number, :verified, :sign_in_count)
end

def nurse_update_params
  params.permit(:email, :first_name, :last_name, :phone_number)
end
