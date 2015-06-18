class CreateMeetups < ActiveRecord::Migration
  def change
    create_table :meetups do |t|
      t.string :title,  null: false
      t.text :description, null: false
      t.string :location, null: false
    end
  end
end
 
