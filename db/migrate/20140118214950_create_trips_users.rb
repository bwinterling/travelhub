class CreateTripsUsers < ActiveRecord::Migration
  def change
    create_table :trip_users do |t|
      t.belongs_to :trip
      t.belongs_to :user

      t.timestamps
    end
  end
end
