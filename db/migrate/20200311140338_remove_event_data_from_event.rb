class RemoveEventDataFromEvent < ActiveRecord::Migration[5.1]
  def change
    remove_column :events, :event_data, :datetime
  end
end
