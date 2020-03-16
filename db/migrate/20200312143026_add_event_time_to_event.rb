class AddEventTimeToEvent < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :Event_time, :string
  end
end
