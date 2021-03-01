class ChangeNumberToStringInSchedules < ActiveRecord::Migration[6.1]
  def change
    change_column :schedules, :duration, :string
  end
end
