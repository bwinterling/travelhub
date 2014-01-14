class CreateFeedSources < ActiveRecord::Migration
  def change
    create_table :feed_sources do |t|
      t.references :user, index: true
      t.string :provider
      t.string :token

      t.timestamps
    end
  end
end
