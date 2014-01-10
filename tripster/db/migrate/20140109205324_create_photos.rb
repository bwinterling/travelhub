class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.references :user, index: true
      t.text :photo_id
      t.text :thumbnail_url
      t.text :standard_url
      t.text :caption
      t.datetime :photo_taken

      t.timestamps
    end
  end
end
