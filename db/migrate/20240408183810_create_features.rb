class CreateFeatures < ActiveRecord::Migration[7.1]
  def change
    create_table :features do |t|
      t.decimal :mag
      t.string :place, null: false
      t.integer :time, null: false
      t.string :url, null: false
      t.integer :tsunami
      t.string :mag_type, null: false
      t.string :title, null: false
      t.decimal :latitude
      t.decimal :longitude
      t.string :record_id

      t.timestamps
    end

    add_index :features, :record_id, unique: true
    add_check_constraint :features, 'mag >= -1.0 AND mag <= 10.0', name: 'mag_check'
    add_check_constraint :features, 'latitude >= -90.0 AND mag <= 90.0', name: 'latitude_check'
    add_check_constraint :features, 'longitude >= -180.0 AND mag <= 180.0', name: 'longitude_check'
  end
end
