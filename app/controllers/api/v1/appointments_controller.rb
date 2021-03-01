class Api::V1::AppointmentsController < ApplicationController
  before_action :authorize, only: %i[create update destroy]
  before_action :set_appointment, only: %i[show update destroy]
  before_action :set_patient, only: %i[create]

  def index
    if params[:patient_id].present?
      @patient = Patient.find(params[:patient_id])
      @appointments = @patient.appointments.patient_appointments(@patient.id)
    end

    if params[:doctor_id].present?
      @doctor = Doctor.find(params[:doctor_id])
      @appointments = @doctor.appointments.doctor_appointments(@doctor.id)
    end

    render json: @appointments
  end

  def show
    render json: @appointment
  end

  def create
    @appointment = @patient.appointments.new(appointment_params)

    if @appointment.save
      render json: @appointment, status: :created
    else
      render json: @appointment.errors, status: :unprocessable_entity
    end
  end

  def update
    if @appointment.update(appointment_params)
      render json: @appointment
    else
      render json: @appointment.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @appointment.destroy
  end

  private

  def set_appointment
    @appointment = Appointment.find(params[:id])
  end

  def set_patient
    @patient = Patient.find(params[:patient_id])
  end

  def appointment_params
    params.require(:appointment).permit(:schedule_id, :patient_id, :doctor_id)
  end
end
