class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.string :title
      t.datetime :event_data
      t.string :event_place
      t.string :event_style
      t.text :body
      t.string :time

      t.timestamps
    end
  end
end
