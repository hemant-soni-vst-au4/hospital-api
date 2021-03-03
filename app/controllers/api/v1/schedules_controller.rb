class Api::V1::SchedulesController < ApplicationController
  before_action :authorize, only: %i[create update destroy]
  before_action :set_schedule, only: %i[show update destroy]
  before_action :set_doctor, only: %i[index create]

  def index
    @schedules = @doctor.schedules
    render json: @schedules
  end

  def show
    render json: @schedule
  end

  def create
    start_date = Time.parse(schedule_params[:start_date]).to_i
    end_date = Time.parse(schedule_params[:end_date]).to_i
    start_time = Time.parse(schedule_params[:start_time]).to_i
    end_time = Time.parse(schedule_params[:end_time]).to_i
    duration = schedule_params[:duration].to_i

    @time_slots = (start_date..end_date).step(86_400).each do |date|
      (start_time..end_time).step(duration * 60).each do |time|
        slot_date = Time.at(date).strftime('%D')
        slot_time = "#{slot_date} #{Time.at(time).strftime('%H:%M')}"
        @doctor.schedules.create(date: slot_date, time: slot_time, duration: duration)
      end
    end

    if @time_slots
      render json: { status: 'SUCCESS', message: 'Successfully posted' }
    else
      render json: @schedule.errors, status: :unprocessable_entity
    end
  end

  def update
    if @schedule.update(schedule_params)
      render json: @schedule
    else
      render json: @schedule.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @schedule.destroy
  end

  private

  def set_schedule
    @schedule = Schedule.find(params[:id])
  end

  def set_doctor
    @doctor = Doctor.find(params[:doctor_id])
  end

  def schedule_params
    params.require(:schedule).permit(:start_date, :start_time, :end_date, :end_time, :duration, :doctor_id)
  end
end
