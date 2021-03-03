class RenameScheduleIntervalToDuration < ActiveRecord::Migration[6.1]
  def change
    rename_column :schedules, :interval, :duration
  end
end
