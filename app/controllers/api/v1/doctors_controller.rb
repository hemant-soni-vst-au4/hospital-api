class Api::V1::DoctorsController < ApplicationController
    
    def index
        @doctor = Doctor.all

        render json: @doctor
    end

    def show
        render json: @doctor
    end

    def create
        @doctor = Doctor.create(doctor_params)

        if @doctor.valid?
            render json: { doctor: @doctor }
        else
            render json: { error: 'Email already exist'}
        end
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
        params.require(:doctor).permit(:name, :email, :password, :specialisation, :experience, :fee)

end