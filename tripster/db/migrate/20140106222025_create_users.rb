class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :avatar_url
      t.string :name

      t.timestamps
    end
  end
end
