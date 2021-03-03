class RenameAppointmentsDurationToAppointmentTime < ActiveRecord::Migration[6.1]
  def change
    rename_column :appointments, :duration, :appointment_time
  end
end
