class Api::V1::PatientsController < ApplicationController
  
    # GET /patients
    def index
      @patients = Patient.all
  
      render json: @patients
    end

  # GET /patients/1
    def show
        render json: @patient
    end

    # POST /patients
    def create
        @patient = Patient.create(patient_params)

        if @patient.valid?
        render json: { patient: @patient }
        else
        render json: { error: 'Email already registered' }
        end
    end


    # PATCH/PUT /patients/1
    def update
        if @patient.update(patient_params)
        render json: @patient
        else
        render json: @patient.errors, status: :unprocessable_entity
        end
    end

    # DELETE /patients/1
    def destroy
        @patient.destroy
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_patient
        @patient = Patient.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def patient_params
        params.require(:patient).permit(:name, :email, :password, :image)
    end
end