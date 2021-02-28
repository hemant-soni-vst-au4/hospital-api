class ChangeTimeToBeStringInAppointment < ActiveRecord::Migration[6.1]
  def change
    change_column :appointments, :appointment_time, :string
  end
end
