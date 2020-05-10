class CreateEventimages < ActiveRecord::Migration[5.1]
  def change
    create_table :eventimages do |t|
      t.string :name
      t.string :image

      t.timestamps
    end
  end
end
