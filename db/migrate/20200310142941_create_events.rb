class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.string :name
      t.date :from_date
      t.date :to_date
      t.time :from_time
      t.time :to_time
      t.integer :style_id
      t.integer :eventimage_id
      t.string :prefecture
      t.integer :price
      t.integer :count_works
      t.text :discription
      t.string :link_url

      t.timestamps
    end
  end
end
