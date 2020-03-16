class AddEventFromDateToEvent < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :event_from_date, :date
  end
end
