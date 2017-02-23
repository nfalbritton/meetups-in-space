class Meetups < ActiveRecord::Migration
  def change
    create_table :meetups do |table|
      table.string :name, null: false
      table.string :location, null: false
      table.string :date, null: false
      table.string :time, null: false
      table.text :description, null: false
      table.string :email, null: false

    table.timestamps null: false
    end
  end
end
  
