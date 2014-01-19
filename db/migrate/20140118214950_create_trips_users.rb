class CreateTripsUsers < ActiveRecord::Migration
  def change
    create_table :trip_users do |t|
      t.integer :trip_id
      t.integer :user

      t.timestamps
    end
  end
end
