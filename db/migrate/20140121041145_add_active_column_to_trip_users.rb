class AddActiveColumnToTripUsers < ActiveRecord::Migration
  def change
    add_column :trip_users, :active, :boolean, default: true
  end
end
