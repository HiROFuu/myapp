class CreateContacts < ActiveRecord::Migration[5.1]
  def change
    create_table :contacts do |t|
      t.string :name
      t.string :email
      t.string :category
      t.text :content
      t.string :status

      t.timestamps
    end
  end
end
