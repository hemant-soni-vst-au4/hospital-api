class Api::V1::DoctorsController < ApplicationController
  before_action :authorize, only: %i[auto_login update destroy]
  before_action :set_doctor, only: %i[show update destroy]

  def index
    @doctors = Doctor.all

    render json: @doctors
  end

  def show
    render json: @doctor
  end

  def create
    @doctor = Doctor.create(doctor_params)

    if @doctor.valid?
      token = encode_token({ doctor_id: @doctor.id })
      render json: { doctor: @doctor, token: token }
    else
      render json: { error: 'Email already registered' }
    end
  end

  def login
    @doctor = Doctor.find_by(email: doctor_params[:email])

    if @doctor&.authenticate(doctor_params[:password])
      token = encode_token({ doctor_id: @doctor.id })
      render json: { doctor: @doctor, token: token }
    else
      render json: { error: 'Invalid username or password' }
    end
  end

  def auto_login
    token = encode_token({ doctor_id: @doctor.id })
    render json: { doctor: @doctor, token: token }
  end

  def update
    if @doctor.update(doctor_params)
      render json: @doctor
    else
      render json: @doctor.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @doctor.destroy
  end

  private

  def set_doctor
    @doctor = Doctor.find(params[:id])
  end

  def doctor_params
    params.require(:doctor).permit(:name, :email, :password, :specialization, :experience, :fee, :image)
  end
end
