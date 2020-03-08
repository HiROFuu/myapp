class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.string :title
      t.datetime :eventdate
      t.string :eventplace
      t.string :eventstyle
      t.text :body

      t.timestamps
    end
  end
end
