class CreateCityDistricts < ActiveRecord::Migration
  def change
    create_table :city_districts do |t|
      t.integer :zip
      t.string :name
      t.float :longitude
      t.float :latitude
      t.timestamps null: false
    end
  end
end
