class AddEventToDateToEvent < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :event_to_date, :date
  end
end
