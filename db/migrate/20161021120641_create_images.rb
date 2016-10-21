class CreateImages < ActiveRecord::Migration[5.0]
  def change
    create_table :images do |t|
      t.json :image_data

      t.timestamps
    end
  end
end
