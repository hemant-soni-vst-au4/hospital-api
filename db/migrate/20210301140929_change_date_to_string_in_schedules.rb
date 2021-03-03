class ChangeDateToStringInSchedules < ActiveRecord::Migration[6.1]
  def change
    change_column :schedules, :date, :string
  end
end
